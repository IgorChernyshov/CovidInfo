//
//  Covid19SummaryParser.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 04.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

class Covid19SummaryParser {

	private func makeCountriesDataArrayFromData(_ data: Data) -> Array<Dictionary<String, Any>>? {
		guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
			let response = json as? Dictionary<String, Any>,
			let countries = response["Countries"] as? Array<Dictionary<String, Any>> else { return nil }

		return countries
	}
}

extension Covid19SummaryParser: SummaryParserProtocol {

	func makeCountrySummaryModel(data: Data, countryName: String) -> CountrySummaryModel? {
		guard let countriesDataArray = makeCountriesDataArrayFromData(data) else { return nil }

		for countryData in countriesDataArray {
			if countryData["Country"] as? String == countryName {
				guard let newConfirmed = countryData["NewConfirmed"] as? Int,
					let newDeaths = countryData["NewDeaths"] as? Int
					else { return nil }
				return CountrySummaryModel(countryName: countryName, newConfirmed: newConfirmed, newDeaths: newDeaths, totalActiveCases: 0)
			}
		}

		return nil
	}
}
