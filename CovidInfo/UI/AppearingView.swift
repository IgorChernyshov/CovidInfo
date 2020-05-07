//
//  AppearingView.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 07.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

protocol AppearingView: UIView {
	func updateViewState(visible: Bool, animated: Bool)
}

extension AppearingView {
	func updateViewState(visible: Bool, animated: Bool) {
		let alpha = CGFloat(visible ? 1.0 : 0.0)
		let duration = animated ? 0.5 : 0.0
		UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseOut, animations: {
			self.alpha = alpha
		}, completion: nil)
	}
}
