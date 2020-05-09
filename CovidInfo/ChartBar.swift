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

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(chartBar)

		NSLayoutConstraint.activate([
			chartBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			chartBar.topAnchor.constraint(equalTo: self.topAnchor),
			chartBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		])
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Public Methods

	func updateBar(value: Int, maxValue: Int, color: UIColor) {
		guard maxValue != 0 else { return }

		self.backgroundColor = color.withAlphaComponent(0.2)
		chartBar.backgroundColor = color

		if constraints.last == widthConstraint {
			removeConstraint(widthConstraint)
		}

		let filledRatio = CGFloat(value) / CGFloat(maxValue)
		widthConstraint = chartBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: filledRatio)
		NSLayoutConstraint.activate([widthConstraint])
	}
}
