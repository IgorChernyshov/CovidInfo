//
//  APIService.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class APIService {
	private let apiURL = URL(string: "https://api.covid19api.com/summary")!
}

extension APIService: APIServiceProtocol {

	func makeRequestURL() -> URL {
		return apiURL
	}
}
