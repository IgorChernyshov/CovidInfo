//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 03.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class MainViewContoller: UIViewController {

	// MARK: Outlets

	@IBOutlet weak var totalCasesLabel: UILabel!
	@IBOutlet weak var totalRecoveredLabel: UILabel!
	@IBOutlet weak var totalDeathsLabel: UILabel!

	@IBOutlet weak var activeCasesLabel: UILabel!
	@IBOutlet weak var seriousCasesLabel: UILabel!

	@IBOutlet weak var newConfirmedLabel: UILabel!
	@IBOutlet weak var newDeathsLabel: UILabel!

	@IBOutlet weak var dangerRankLabel: UILabel!

	// MARK: Variables

	private lazy var spinner: SpinnerProtocol = {
		return FullScreenSpinnerView(addToView: self.view)
	}()

	var summaryModel: TheVirusTrackerResponse.CountryData? {
		didSet {
			updateLabels()
		}
	}

	// MARK: Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		downloadSummaryModel()
	}

	// MARK: Button actions

	@IBAction func refreshButtonDidTap(_ sender: Any) {
		downloadSummaryModel()
	}

	// MARK: Private

	private func downloadSummaryModel() {
		spinner.showSpinner()

		let apiService = APIService(serviceProvider: .theVirusTracker)
		let networkService = NetworkService(apiService: apiService)
		let summaryParser = TheVirusTrackerCountrySummaryParser()

		networkService.requestData { [weak self] data in
			guard let self = self else { return }
			guard let summaryModel = summaryParser.makeCountrySummaryModel(data: data, countryName: "Russian Federation")
				else { return }
			self.summaryModel = summaryModel
		}
	}

	private func updateLabels() {
		guard let summaryModel = self.summaryModel else { return }
		DispatchQueue.main.sync {
			totalCasesLabel.text = "\(summaryModel.totalCases)"
			totalRecoveredLabel.text = "\(summaryModel.totalRecovered)"
			totalDeathsLabel.text = "\(summaryModel.totalDeaths)"

			activeCasesLabel.text = "\(summaryModel.activeCases)"
			seriousCasesLabel.text = "\(summaryModel.seriousCases)"

			newConfirmedLabel.text = "\(summaryModel.newCases)"
			newDeathsLabel.text = "\(summaryModel.newDeaths)"

			dangerRankLabel.text = "\(summaryModel.dangerRank) из 10"

			spinner.hideSpinner()
		}
	}
}
