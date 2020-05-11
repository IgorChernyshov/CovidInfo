//
//  CountryStats.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 05.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

struct CountryStats {
	let countryData: [Data]
}

extension CountryStats: Decodable {
	enum CodingKeys: String, CodingKey {
		case countryData = "countrydata"
	}
}
