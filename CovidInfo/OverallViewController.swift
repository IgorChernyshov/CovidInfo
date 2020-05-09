//
//  OverallViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class OverallViewController: UIViewController {

    // MARK: Subviews

	private lazy var titleLabel: UILabel = {
		let title = Label(style: Label.Style.header)
		title.text = "За всё время"
		return title
	}()

	private let overallStatisticsView = OverallStatisticsView()

	// MARK: View Controller's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

		view.addSubview(titleLabel)
		view.addSubview(overallStatisticsView)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
			titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0),
			titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),

			overallStatisticsView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24.0),
			overallStatisticsView.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
			overallStatisticsView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
			overallStatisticsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16.0),
		])
    }

	// MARK: Public Methods

	func updateInformation(total: Int, active: Int, recovered: Int, deaths: Int, critical: Int) {
		overallStatisticsView.updateCasesInformation(total: total, active: active, recovered: recovered, deaths: deaths, critical: critical)
	}
}
