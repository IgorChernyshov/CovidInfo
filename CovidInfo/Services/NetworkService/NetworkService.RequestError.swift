//
//  NetworkService.RequestError.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 05.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

extension NetworkService {
	enum RequestError: Error {
		case networkIssue
		case noDataReceived
	}
}
