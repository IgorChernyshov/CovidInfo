//
//  FullScreenSpinnerView.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 04.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class FullScreenSpinnerView: UIView {

	private var backgroundView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(named: "SpinnerBackgroundViewColor")
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private var spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
		spinner.color = UIColor(named: "SpinnerColor")
		spinner.startAnimating()
		spinner.translatesAutoresizingMaskIntoConstraints = false
		return spinner
	}()

	init(addToView view: UIView) {
		super.init(frame: CGRect.zero)
		backgroundView.addSubview(spinner)
		view.addSubview(backgroundView)
		NSLayoutConstraint.activate([
			backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
			backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

			spinner.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
			spinner.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor)
		])
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension FullScreenSpinnerView: SpinnerProtocol {

	func showSpinner() {
		self.backgroundView.isHidden = false
	}

	func hideSpinner() {
		self.backgroundView.isHidden = true
	}
}
