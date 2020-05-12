//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 10.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	// MARK: Subviews

	private let applicationHeader = Label(style: Label.Style.applicationHeader, text: "COVID-19 в России")
	private let pageViewController = ContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
	private let networkErrorBanner: AppearingView = NetworkErrorBanner(alignment: .top)
	private let spinner: AppearingView = FullScreenSpinnerView()

	// MARK: Services

	private lazy var networkService = NetworkService(apiService: apiService)
	private let apiService = APIService()

	// MARK: View Controller's Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		addSubviews()
		configureConstraints()

		downloadDailyStatistics()
	}

	// MARK: UI Configuration

	private func addSubviews() {
		view.addSubview(applicationHeader)
		addPageViewController()
		view.addSubview(networkErrorBanner)
		view.addSubview(spinner)
	}

	private func addPageViewController() {
		addChild(pageViewController)
		view.addSubview(pageViewController.view)
		pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
		pageViewController.didMove(toParent: self)
	}

	private func configureConstraints() {
		NSLayoutConstraint.activate([
			applicationHeader.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
			applicationHeader.leftAnchor.constraint(equalTo: view.leftAnchor),
			applicationHeader.rightAnchor.constraint(equalTo: view.rightAnchor),

			pageViewController.view.topAnchor.constraint(equalTo: applicationHeader.bottomAnchor),
			pageViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
			pageViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
			pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			networkErrorBanner.leftAnchor.constraint(equalTo: view.leftAnchor),
			networkErrorBanner.rightAnchor.constraint(equalTo: view.rightAnchor),
			networkErrorBanner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			networkErrorBanner.heightAnchor.constraint(equalToConstant: 64.0),

			spinner.topAnchor.constraint(equalTo: view.topAnchor),
			spinner.leftAnchor.constraint(equalTo: view.leftAnchor),
			spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			spinner.rightAnchor.constraint(equalTo: view.rightAnchor)
		])
	}

	// MARK: Networking

	private func downloadDailyStatistics() {
		self.spinner.updateViewState(visible: true, animated: false)
		self.networkErrorBanner.updateViewState(visible: false, animated: true)

		let summaryParser = TheVirusTrackerCountrySummaryParser()
		
		networkService.requestData(type: .countryTotal) { [weak self] result in
			guard let self = self else { return }

			self.spinner.updateViewState(visible: false, animated: false)
			switch result {
			case .failure:
				self.networkErrorBanner.updateViewState(visible: true, animated: true)
			case .success(let data):
				guard let summaryModel = summaryParser.makeCountrySummaryModel(data: data) else { return }
				self.pageViewController.updateDailyInformation(model: summaryModel)
				self.pageViewController.updateOverallInformation(model: summaryModel)
				if summaryModel.newCases > 0 && summaryModel.newDeaths > 0 {
					self.downloadTimelineStatisticsInBackground()
				}
			}
		}
	}

	private func downloadTimelineStatisticsInBackground() {
		let timelineParser = TheVirusTrackerCountryTimelineParser()

		networkService.requestData(type: .countryTimeline) { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .failure:
				// This is a secondary data, so we do not bother user with details in case of error
				return
			case .success(let data):
				guard let timelineModel = timelineParser.makeCountryTimelineModel(data: data) else { return }
				self.pageViewController.updateTimelineInformation(model: timelineModel)
			}
		}
	}
}
