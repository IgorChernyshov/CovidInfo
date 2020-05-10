//
//  APIService.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class APIService {
	private static let countryTotalURL = URL(string: "https://api.thevirustracker.com/free-api?countryTotal=RU")!
	private static let countryTimelineURL = URL(string: "https://api.thevirustracker.com/free-api?countryTimeline=RU")!
}

extension APIService: APIServiceProtocol {
	
	func makeRequestURL(type: APIServiceRequestType) -> URL {
		switch type {
		case .countryTotal:
			return APIService.countryTotalURL
		case .countryTimeline:
			return APIService.countryTimelineURL
		}
	}
}
