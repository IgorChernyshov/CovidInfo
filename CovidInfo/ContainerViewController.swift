//
//  ContainerViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class ContainerViewController: UIPageViewController {

	// MARK: Subviews

	private lazy var orderedViewControllers = [dailyViewController, overallViewController]
	private let dailyViewController = DailyViewController()
	private let overallViewController = OverallViewController()

	// MARK: View Controller's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

		self.dataSource = self
		setViewControllers([dailyViewController], direction: .forward, animated: true, completion: nil)
    }

	// MARK: Public

	func updateDailyInformation(model: TheVirusTrackerResponse.CountryData) {
		let newCases = model.newCases
		let newDeaths = model.newDeaths
		let dangerRank = model.dangerRank
		self.dailyViewController.updateCounters(newCases: newCases, newDeaths: newDeaths, dangerRank: dangerRank)
	}

	func updateTimelineInformation(model: TheVirusTrackerTimelineResponse) {
		let cases = model.newCases
		let deaths = model.newDeaths
		dailyViewController.updateCountersWithDelta(yesterdaysCases: cases, yesterdaysDeaths: deaths)
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

	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return orderedViewControllers.count
	}

	func presentationIndex(for pageViewController: UIPageViewController) -> Int {
		return 0
	}
}
