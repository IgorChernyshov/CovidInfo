//
//  Label.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class Label: UILabel {

	// MARK: Initializers

	convenience init(style: Style) {
		self.init(style: style, text: nil)
	}

	init(style: Style, text: String?) {
		super.init(frame: CGRect.zero)

		switch style {
		case .applicationHeader:
			self.font = SemanticFonts.Headers.applicationHeader
		case .header:
			self.font = SemanticFonts.Headers.containedView
		case .subheader:
			self.font = SemanticFonts.Headers.containedViewSubheader
		case .counter:
			self.font = SemanticFonts.Counters.counter
		case .chartLabel:
			self.font = SemanticFonts.Charts.chartLabel
		case .tip:
			self.font = SemanticFonts.Headers.tip
		}

		self.translatesAutoresizingMaskIntoConstraints = false
		self.text = text ?? "🦠"
		self.textAlignment = .center
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension Label {
	enum Style {
		case applicationHeader
		case header
		case subheader
		case counter
		case chartLabel
		case tip
	}
}
