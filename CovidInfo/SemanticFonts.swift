//
//  SemanticFonts.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 09.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

struct SemanticFonts {}

extension UIFont {

	convenience init?(size: CGFloat) {
		self.init(attribute: nil, size: size)
	}

	convenience init?(attribute: String?, size: CGFloat) {
		var fontName = "HelveticaNeue"
		if attribute != nil {
			fontName.append("-\(attribute!)")
		}
		self.init(name: fontName, size: size)
	}
}

extension SemanticFonts {

	struct Headers {
		static let containedView = UIFont(attribute: "Bold", size: 30.0)!
		static let containedViewSubheader = UIFont(attribute: "Medium", size: 24.0)!
	}

	struct Counters {
		static let counter = UIFont(attribute: "Bold", size: 30.0)!
	}
}
