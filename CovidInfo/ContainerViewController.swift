//
//  ContainerViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class ContainerViewController: UIPageViewController {

	private lazy var orderedViewControllers: [UIViewController] = {
		return [dailyViewController, overallViewController]
	}()

	private let dailyViewController = DailyViewController()

	private let overallViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "overallViewController")

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
				let newCases = summaryModel.newCases
				let newDeaths = summaryModel.newDeaths
				let dangerRank = summaryModel.dangerRank
				self.dailyViewController.updateCounters(newCases: newCases, newDeaths: newDeaths, dangerRank: dangerRank)
			}
		}
	}
}

extension ContainerViewController: UIPageViewControllerDelegate {}

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
