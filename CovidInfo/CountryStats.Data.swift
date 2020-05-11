//
//  CountryStats.Data.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 05.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

extension CountryStats {

	struct Data {

		let totalCases: Int
		let totalRecovered: Int
		let totalDeaths: Int

		let activeCases: Int
		let seriousCases: Int

		let newCases: Int
		let newDeaths: Int

		let dangerRank: Int
	}
}

extension CountryStats.Data: Decodable {

	enum CodingKeys: String, CodingKey {
		case totalCases = "total_cases"
		case totalRecovered = "total_recovered"
		case totalDeaths = "total_deaths"

		case activeCases = "total_active_cases"
		case seriousCases = "total_serious_cases"

		case newCases = "total_new_cases_today"
		case newDeaths = "total_new_deaths_today"

		case dangerRank = "total_danger_rank"
	}
}
