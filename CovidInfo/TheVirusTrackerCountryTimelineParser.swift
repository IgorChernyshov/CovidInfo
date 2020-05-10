//
//  TheVirusTrackerCountryTimelineParser.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 10.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class TheVirusTrackerCountryTimelineParser {

	private static let dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM'/'dd'/'yy"
		return dateFormatter
	}()

	private var yesterdaysDate: String? = {
		let now = Calendar.current.dateComponents(in: .current, from: Date())
		guard let dayNow = now.day else { return nil }
		let yesterday = DateComponents(year:now.year, month:now.month, day: dayNow - 1)
		guard let dateYesterday = Calendar.current.date(from: yesterday) else { return nil }
		var yesterdayString = dateFormatter.string(from: dateYesterday)
		if yesterdayString.first == "0" {
			yesterdayString.removeFirst()
		}
		return yesterdayString
	}()
}

extension TheVirusTrackerCountryTimelineParser: TimelineParserProtocol {

	func makeCountryTimelineModel(data: Data) -> TheVirusTrackerTimelineResponse? {
		do {
			let serializedResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
			guard let timelineItemsContainer = serializedResponse?["timelineitems"] as? [Any],
				let timelineItems = timelineItemsContainer.first as? [String : Any] else { return nil }

			guard let yesterday = yesterdaysDate,
				let yesterdaysData = timelineItems[yesterday] as? [String : Int],
				let cases = yesterdaysData["new_daily_cases"],
				let deaths = yesterdaysData["new_daily_deaths"] else { return nil }

			let yesterdaysItem = TheVirusTrackerTimelineResponse(newCases: cases, newDeaths: deaths)
			return yesterdaysItem
		} catch {
			print("Country timeline model parsing error: \(error).")
		}
		return nil
	}
}
