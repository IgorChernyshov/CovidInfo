//
//  DailyViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class DailyViewController: UIViewController {

	// MARK: Subviews

	private lazy var titleLabel: UILabel = {
		let title = Label(style: Label.Style.header)
		title.text = "Сегодня"
		return title
	}()

	private let dailyStatisticsView = DailyStatisticsView()

	// MARK: View Controller's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = SemanticColors.ViewControllers.background

		view.addSubview(titleLabel)
		view.addSubview(dailyStatisticsView)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
			titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
			titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),

			dailyStatisticsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.0),
			dailyStatisticsView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
			dailyStatisticsView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
			dailyStatisticsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0),
		])
    }

	// MARK: Public Methods

	func updateCounters(newCases: Int, newDeaths: Int, dangerRank: Int) {
		dailyStatisticsView.updateInformation(cases: newCases, deaths: newDeaths, dangerRank: dangerRank)
	}
}
