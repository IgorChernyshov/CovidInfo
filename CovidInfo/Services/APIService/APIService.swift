//
//  APIService.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

enum APIServiceProvider {
	case covid19API
	case theVirusTracker
}

final class APIService {

	private let apiURL: URL

	init(serviceProvider: APIServiceProvider) {
		switch serviceProvider {
		case .covid19API:
			self.apiURL = URL(string: "https://api.covid19api.com/summary")!
		case .theVirusTracker:
			self.apiURL = URL(string: "https://api.thevirustracker.com/free-api?countryTotal=RU")!
		}
	}
}

extension APIService: APIServiceProtocol {

	func makeRequestURL() -> URL {
		return apiURL
	}
}
