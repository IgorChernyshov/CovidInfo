//
//  TheVirusTrackerTimelineItemResponse.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 10.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

struct TheVirusTrackerTimelineResponse {

	let newCases: Int
	let newDeaths: Int
}

extension TheVirusTrackerTimelineResponse: Decodable {

	enum CodingKeys: String, CodingKey {
		case newCases = "new_daily_cases"
		case newDeaths = "new_daily_deaths"
	}
}
