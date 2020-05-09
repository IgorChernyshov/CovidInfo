//
//  ChartLabel.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class ChartLabel: UIView {

	// MARK: Subviews

	private let label = Label(style: Label.Style.chartLabel)
	private let chartBar = ChartBar()

	// MARK: Private Constants

	private let descriptionText: String

	// MARK: Initializers

	init(descriptionText: String) {
		self.descriptionText = descriptionText
		super.init(frame: CGRect.zero)

		translatesAutoresizingMaskIntoConstraints = false
		placeSubviews()
		configureConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: UI Configuration

	private func placeSubviews() {
		addSubview(chartBar)
		addSubview(label)
	}

	private func configureConstraints() {
		NSLayoutConstraint.activate([
			chartBar.topAnchor.constraint(equalTo: self.topAnchor),
			chartBar.leftAnchor.constraint(equalTo: self.leftAnchor),
			chartBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			chartBar.rightAnchor.constraint(equalTo: self.rightAnchor),
			
			label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
			label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
			label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
			label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
		])
	}

	// MARK: Public

	func updateInformation(value: Int, maxValue: Int, color: UIColor) {

		let labelText = "\(descriptionText): \(value)"
		label.text = labelText

		chartBar.updateBar(value: value, maxValue: maxValue, color: color)
	}
}
