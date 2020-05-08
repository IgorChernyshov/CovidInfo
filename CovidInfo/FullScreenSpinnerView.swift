//
//  FullScreenSpinnerView.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 04.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class FullScreenSpinnerView: UIView {

	override init(frame: CGRect) {
		super.init(frame: frame)

		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = SemanticColors.Spinners.spinnerBackground

		let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
		spinner.translatesAutoresizingMaskIntoConstraints = false
		spinner.color = SemanticColors.Spinners.spinnerColor
		spinner.startAnimating()
		
		self.addSubview(spinner)

		NSLayoutConstraint.activate([
			spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])

		self.alpha = 0.0
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension FullScreenSpinnerView: AppearingView {}
