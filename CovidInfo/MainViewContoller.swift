//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class MainViewContoller: UIViewController {

	// MARK: Outlets

	@IBOutlet weak var totalCasesLabel: UILabel!
	@IBOutlet weak var totalRecoveredLabel: UILabel!
	@IBOutlet weak var totalDeathsLabel: UILabel!

	@IBOutlet weak var activeCasesLabel: UILabel!
	@IBOutlet weak var seriousCasesLabel: UILabel!

	@IBOutlet weak var newConfirmedLabel: UILabel!
	@IBOutlet weak var newDeathsLabel: UILabel!

	@IBOutlet weak var dangerRankLabel: UILabel!

	// MARK: Variables

	private lazy var networkErrorBanner: AppearingView = {
		return NetworkErrorBanner(alignment: .top)
	}()

	private lazy var spinner: AppearingView = {
		return FullScreenSpinnerView()
	}()

	private var summaryModel: TheVirusTrackerResponse.CountryData? {
		didSet {
			updateLabels()
		}
	}

	// MARK: Lifecycle

	override func loadView() {
		super.loadView()

		self.view.addSubview(networkErrorBanner)
		self.view.addSubview(spinner)
		
		NSLayoutConstraint.activate([
			networkErrorBanner.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			networkErrorBanner.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			networkErrorBanner.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			networkErrorBanner.heightAnchor.constraint(equalToConstant: 64.0),

			spinner.topAnchor.constraint(equalTo: self.view.topAnchor),
			spinner.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			spinner.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			spinner.rightAnchor.constraint(equalTo: self.view.rightAnchor)
		])
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		downloadSummaryModel()
	}

	// MARK: Button actions

	@IBAction func refreshButtonDidTap(_ sender: Any) {
		downloadSummaryModel()
	}

	// MARK: Private

	private func downloadSummaryModel() {
		spinner.updateViewState(visible: true, animated: false)

		let apiService = APIService(serviceProvider: .theVirusTracker)
		let networkService = NetworkService(apiService: apiService)
		let summaryParser = TheVirusTrackerCountrySummaryParser()

		networkService.requestData { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .failure:
				self.dataFailedToLoad()
			case .success(let data):
				guard let summaryModel = summaryParser.makeCountrySummaryModel(data: data, countryName: "Russian Federation")
					else { return }
				self.summaryModel = summaryModel
			}
		}
	}

	// MARK: UI Methods

	private func dataFailedToLoad() {
		DispatchQueue.main.sync {
			networkErrorBanner.updateViewState(visible: true, animated: true)
			spinner.updateViewState(visible: false, animated: false)
		}
	}

	private func updateLabels() {
		guard let summaryModel = self.summaryModel else { return }
		DispatchQueue.main.sync {
			networkErrorBanner.updateViewState(visible: false, animated: true)

			totalCasesLabel.text = "\(summaryModel.totalCases)"
			totalRecoveredLabel.text = "\(summaryModel.totalRecovered)"
			totalDeathsLabel.text = "\(summaryModel.totalDeaths)"

			activeCasesLabel.text = "\(summaryModel.activeCases)"
			seriousCasesLabel.text = "\(summaryModel.seriousCases)"

			newConfirmedLabel.text = "\(summaryModel.newCases)"
			newDeathsLabel.text = "\(summaryModel.newDeaths)"

			dangerRankLabel.text = "\(summaryModel.dangerRank) из 10"

			spinner.updateViewState(visible: false, animated: false)
		}
	}
}
