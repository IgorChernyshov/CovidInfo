//
//  NetworkErrorBanner.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 06.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class NetworkErrorBanner: UIView {

	init(alignment: LabelAlignment) {
		super.init(frame: CGRect.zero)

		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIColor(named: "networkErrorBannerBackgroundColor")

		let errorLabel = UILabel()
		errorLabel.translatesAutoresizingMaskIntoConstraints = false
		errorLabel.font = UIFont(name: "HelveticaNeue", size: 14.0)
		errorLabel.textColor = UIColor(named: "networkErrorBannerTextColor")
		errorLabel.text = "Ошибка подключения. Попробуйте ещё раз."
		errorLabel.textAlignment = .center

		self.addSubview(errorLabel)

		let alignmentConstraint: NSLayoutConstraint
		switch alignment {
		case .top:
			alignmentConstraint = errorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0)
		case .center:
			alignmentConstraint = errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		case .bottom:
			alignmentConstraint = errorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 8.0)
		}

		NSLayoutConstraint.activate([
			errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
			errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
			alignmentConstraint
		])

		self.alpha = 0.0
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension NetworkErrorBanner {
	enum LabelAlignment {
		case top, center, bottom
	}
}

extension NetworkErrorBanner: AppearingView {}
