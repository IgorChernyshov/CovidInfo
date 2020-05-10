//
//  TimelineParserProtocol.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 10.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import Foundation

protocol TimelineParserProtocol {
	func makeCountryTimelineModel(data: Data) -> TheVirusTrackerTimelineResponse?
}
