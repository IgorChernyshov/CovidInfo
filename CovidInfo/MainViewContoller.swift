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

	@IBOutlet weak var newConfirmedLabel: UILabel!
	@IBOutlet weak var newDeathsLabel: UILabel!
	@IBOutlet weak var activeCasesLabel: UILabel!

	// MARK: Variables

	private lazy var spinner: SpinnerProtocol = {
		return FullScreenSpinnerView(addToView: self.view)
	}()

	var summaryModel: CountrySummaryModel? {
		didSet {
			updateLabelsWithNewSummary()
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
		let summaryParser = TheVirusTrackerSummaryParser()

		networkService.requestData { [weak self] data in
			guard let self = self else { return }
			guard let summaryModel = summaryParser.makeCountrySummaryModel(data: data, countryName: "Russian Federation")
				else { return }
			self.summaryModel = summaryModel
		}
	}

	private func updateLabelsWithNewSummary() {
		guard let summaryModel = self.summaryModel else { return }
		DispatchQueue.main.sync {
			newConfirmedLabel.text = String(summaryModel.newConfirmed)
			newDeathsLabel.text = String(summaryModel.newDeaths)
			activeCasesLabel.text = String(summaryModel.totalActiveCases)
			spinner.hideSpinner()
		}
	}
}
