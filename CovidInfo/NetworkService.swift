//
//  NetworkService.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

final class NetworkService {

	private lazy var session: URLSession = {
		let session = URLSession.shared
		session.configuration.timeoutIntervalForRequest = 5.0
		return session
	}()

	private let apiService: APIServiceProtocol

	init(apiService: APIServiceProtocol) {
		self.apiService = apiService
	}
}

// MARK: NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {

	func requestData(completion: @escaping(Result<Data, Error>) -> Void) {
		let url = apiService.makeRequestURL()
		let task = session.dataTask(with: url) { data, _, error in
			guard error == nil else {
				completion(.failure(RequestError.networkIssue))
				return
			}
			guard let data = data else {
				completion(.failure(RequestError.noDataReceived))
				return
			}
			completion(.success(data))
		}
		task.resume()
	}
}
