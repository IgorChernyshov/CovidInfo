//
//  ContainerViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class ContainerViewController: UIPageViewController {

	// MARK: Private Variables

	private lazy var orderedViewControllers = [dailyViewController, overallViewController]

	private let dailyViewController = DailyViewController()
	private let overallViewController = OverallViewController()

	// MARK: View Controller's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
		self.dataSource = self
		setViewControllers([dailyViewController], direction: .forward, animated: true, completion: nil)
		downloadStatistics()
    }

	// MARK: Networking

	func downloadStatistics() {
		let apiService = APIService(serviceProvider: .theVirusTracker)
		let networkService = NetworkService(apiService: apiService)
		let summaryParser = TheVirusTrackerCountrySummaryParser()

		networkService.requestData { [weak self] result in
			guard let self = self else { return }

			switch result {
			case .failure:
				break
			case .success(let data):
				guard let summaryModel = summaryParser.makeCountrySummaryModel(data: data, countryName: "Russian Federation")
					else { return }
				self.updateDailyInformation(model: summaryModel)
				self.updateOverallInformation(model: summaryModel)
			}
		}
	}

	// MARK: Private

	func updateDailyInformation(model: TheVirusTrackerResponse.CountryData) {
		let newCases = model.newCases
		let newDeaths = model.newDeaths
		let dangerRank = model.dangerRank
		self.dailyViewController.updateCounters(newCases: newCases, newDeaths: newDeaths, dangerRank: dangerRank)
	}

	func updateOverallInformation(model: TheVirusTrackerResponse.CountryData) {
		let total = model.totalCases
		let active = model.activeCases
		let recovered = model.totalRecovered
		let deaths = model.totalDeaths
		let critical = model.seriousCases
		self.overallViewController.updateInformation(total: total, active: active, recovered: recovered, deaths: deaths, critical: critical)
	}
}

extension ContainerViewController: UIPageViewControllerDataSource {

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		if (viewController == orderedViewControllers.first) {
			return nil
		} else {
			return orderedViewControllers.first
		}
	}

	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		if (viewController == orderedViewControllers.last) {
			return nil
		} else {
			return orderedViewControllers.last
		}
	}
}
