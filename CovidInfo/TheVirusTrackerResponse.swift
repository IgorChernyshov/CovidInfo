//
//  TheVirusTrackerResponse.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 05.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

struct TheVirusTrackerResponse {
	let countryData: [TheVirusTrackerResponse.CountryData]
}

extension TheVirusTrackerResponse: Decodable {

	enum CodingKeys: String, CodingKey {
		case countryData = "countrydata"
	}
}
