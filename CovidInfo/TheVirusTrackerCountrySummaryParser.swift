//
//  TheVirusTrackerCountrySummaryParser.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 05.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class TheVirusTrackerCountrySummaryParser {}

extension TheVirusTrackerCountrySummaryParser: SummaryParserProtocol {

	func makeCountrySummaryModel(data: Data) -> CountryStats.Data? {
		do {
			let serverResponse = try JSONDecoder().decode(CountryStats.self, from: data)
			guard let countryData = serverResponse.countryData.first else { return nil }
			return countryData
		} catch {
			print("Country summary model parsing error: \(error).")
		}
		return nil
	}
}
