//
//  SemanticColors.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 08.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

struct SemanticColors {}

extension SemanticColors {
	struct ChartBars {
		static let activeCases = UIColor(named: "activeCasesChartColor") ?? UIColor.blue
		static let recoveredCases = UIColor(named: "recoveredCasesChartColor") ?? UIColor.green
		static let deathsCases = UIColor(named: "deathsCasesChartColor") ?? UIColor.darkGray
		static let seriousCases = UIColor(named: "seriousCasesChartColor") ?? UIColor.red
	}
}

extension SemanticColors {
	struct ErrorBanners {
		static let networkBannerBackground = UIColor(named: "networkErrorBannerBackgroundColor") ?? UIColor.red.withAlphaComponent(0.7)
		static let networkBannerTextColor = UIColor(named: "networkErrorBannerTextColor") ?? UIColor.red
	}
}

extension SemanticColors {
	struct Spinners {
		static let spinnerBackground = UIColor(named: "spinnerBackgroundViewColor") ?? UIColor.black.withAlphaComponent(0.5)
		static let spinnerColor = UIColor(named: "spinnerColor") ?? UIColor.white
	}
}
