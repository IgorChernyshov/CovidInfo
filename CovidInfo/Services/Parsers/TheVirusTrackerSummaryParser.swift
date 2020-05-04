//
//  TheVirusTrackerSummaryParser.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 04.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class TheVirusTrackerSummaryParser {

	private func serializeData(_ data: Data) -> Dictionary<String, Any> {
		guard let serializedData = try? JSONSerialization.jsonObject(with: data, options:[]),
			let response = serializedData as? Dictionary<String, Any>
			else { return Dictionary<String, Any>() }
		return response
	}
}

extension TheVirusTrackerSummaryParser: SummaryParserProtocol {

	func makeCountrySummaryModel(data: Data, countryName: String) -> CountrySummaryModel? {
		let serverResponse = serializeData(data)
		guard let countryDataArray = serverResponse["countrydata"] as? Array<Any>,
			let countryData = countryDataArray.first as? Dictionary<String, Any>
			else { return nil }

		guard let newConfirmed = countryData["total_new_cases_today"] as? Int,
			let newDeaths = countryData["total_new_deaths_today"] as? Int,
			let totalActiveCases = countryData["total_active_cases"] as? Int
			else { return nil }

		let model = CountrySummaryModel(countryName: countryName, newConfirmed: newConfirmed, newDeaths: newDeaths, totalActiveCases: totalActiveCases)
		return model
	}
}
