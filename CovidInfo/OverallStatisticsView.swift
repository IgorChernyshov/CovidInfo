//
//  OverallStatisticsView.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class OverallStatisticsView: UIView {

	// MARK: Subviews

	private lazy var totalCases = Label(style: Label.Style.subheader, text: "Заболели")
	private lazy var totalCounter = Label(style: Label.Style.counter)

	private lazy var activeCases = ChartLabel(descriptionText: "Сейчас болеет")
	private lazy var recoveredTotal = ChartLabel(descriptionText: "Выздоровели")
	private lazy var deathsTotal = ChartLabel(descriptionText: "Умерли")
	private lazy var criticalCases = ChartLabel(descriptionText: "В тяжёлом состоянии")

	// MARK: Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)

		translatesAutoresizingMaskIntoConstraints = false
		placeSubviews()
		configureConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: UI Configuration

	private func placeSubviews() {
		addSubview(totalCases)
		addSubview(totalCounter)
		addSubview(activeCases)
		addSubview(recoveredTotal)
		addSubview(deathsTotal)
		addSubview(criticalCases)
	}

	private func configureConstraints() {
		NSLayoutConstraint.activate([
			totalCases.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
			totalCases.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
			totalCases.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),

			totalCounter.topAnchor.constraint(equalTo: totalCases.bottomAnchor, constant: 8.0),
			totalCounter.leftAnchor.constraint(equalTo: totalCases.leftAnchor),
			totalCounter.rightAnchor.constraint(equalTo: totalCases.rightAnchor),

			activeCases.topAnchor.constraint(equalTo: totalCounter.bottomAnchor, constant: 16.0),
			activeCases.leftAnchor.constraint(equalTo: totalCounter.leftAnchor),
			activeCases.rightAnchor.constraint(equalTo: totalCounter.rightAnchor),

			recoveredTotal.topAnchor.constraint(equalTo: activeCases.bottomAnchor, constant: 16.0),
			recoveredTotal.leftAnchor.constraint(equalTo: activeCases.leftAnchor),
			recoveredTotal.rightAnchor.constraint(equalTo: activeCases.rightAnchor),

			deathsTotal.topAnchor.constraint(equalTo: recoveredTotal.bottomAnchor, constant: 16.0),
			deathsTotal.leftAnchor.constraint(equalTo: recoveredTotal.leftAnchor),
			deathsTotal.rightAnchor.constraint(equalTo: recoveredTotal.rightAnchor),

			criticalCases.topAnchor.constraint(equalTo: deathsTotal.bottomAnchor, constant: 16.0),
			criticalCases.leftAnchor.constraint(equalTo: deathsTotal.leftAnchor),
			criticalCases.rightAnchor.constraint(equalTo: deathsTotal.rightAnchor),
			criticalCases.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16.0),
		])
	}

	// MARK: Public Methods

	func updateCasesInformation(total: Int, active: Int, recovered: Int, deaths: Int, critical: Int) {
		totalCounter.text = "\(total)"
		activeCases.updateInformation(value: active, maxValue: total, color: SemanticColors.ChartBars.activeCases)
		recoveredTotal.updateInformation(value: recovered, maxValue: total, color: SemanticColors.ChartBars.recoveredCases)
		deathsTotal.updateInformation(value: deaths, maxValue: total, color: SemanticColors.ChartBars.deathsCases)
		criticalCases.updateInformation(value: critical, maxValue: total, color: SemanticColors.ChartBars.criticalCases)
	}
}
