//
//  SummaryParserProtocol.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 04.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

protocol SummaryParserProtocol {
	func makeCountrySummaryModel(data: Data) -> CountryStats.Data?
}
