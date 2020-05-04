//
//  NetworkService.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class NetworkService {

	private let session = URLSession.shared
	private let apiService: APIServiceProtocol

	init(apiService: APIServiceProtocol) {
		self.apiService = apiService
	}
}

// MARK: NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {

	func requestData(completion: @escaping(Data) -> Void) {
		let url = apiService.makeRequestURL()
		let task = session.dataTask(with: url) { data, _, _ in
			guard let data = data else { return }
			completion(data)
		}
		task.resume()
	}
}
