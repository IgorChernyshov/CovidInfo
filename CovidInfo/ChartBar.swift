//
//  ChartBar.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 08.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class ChartBar: UIView {

	// MARK: Private Variables

	private let chartBar: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private var widthConstraint = NSLayoutConstraint()

	// MARK: Initializer

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		self.addSubview(chartBar)

		widthConstraint = chartBar.widthAnchor.constraint(equalToConstant: 0.0)
		NSLayoutConstraint.activate([
			chartBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			chartBar.topAnchor.constraint(equalTo: self.topAnchor),
			chartBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			widthConstraint
		])
	}

	// MARK: Public Methods

	func updateBar(value: Int, maxValue: Int, color: UIColor?) {
		guard maxValue != 0 else { return }
		guard let color = color else { return }

		self.backgroundColor = color.withAlphaComponent(0.2)
		chartBar.backgroundColor = color

		let filledRatio = CGFloat(value) / CGFloat(maxValue)
		let filledBarWidth = self.layer.frame.width * filledRatio
		widthConstraint.constant = filledBarWidth
	}
}
