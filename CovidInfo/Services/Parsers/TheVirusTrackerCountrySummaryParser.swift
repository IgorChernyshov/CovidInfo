//
//  TheVirusTrackerCountrySummaryParser.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 05.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class TheVirusTrackerCountrySummaryParser {

}

extension TheVirusTrackerCountrySummaryParser: SummaryParserProtocol {

	func makeCountrySummaryModel(data: Data, countryName: String) -> TheVirusTrackerResponse.CountryData? {
		do {
			let serverResponse = try JSONDecoder().decode(TheVirusTrackerResponse.self, from: data)
			guard let countryData = serverResponse.countryData.first else { return nil }
			return countryData
		} catch {
			print("Unexpected error: \(error).")
		}
		return nil
	}
}
