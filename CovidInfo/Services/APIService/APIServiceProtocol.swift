//
//  APIServiceProtocol.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

protocol APIServiceProtocol {
	func makeRequestURL() -> URL
}
