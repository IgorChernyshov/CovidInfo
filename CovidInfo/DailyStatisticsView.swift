//
//  DailyStatisticsView.swift
//  CovidInfo
//
//  Created by Igor Chernyshov on 08.05.2020.
//  Copyright © 2020 Igor Chernyshov. All rights reserved.
//

import UIKit

class DailyStatisticsView: UIView {

	// MARK: Constants

	private static let noDataPlaceholder = "пока нет данных"

	// MARK: Cached Information Update

	private var casesCached = 0
	private var deathsCached = 0

	// MARK: Subviews

	private lazy var casesTitle = Label(style: Label.Style.subheader, text: "Новых случаев")

	private lazy var casesCounter: Label = {
		let label = Label(style: Label.Style.counter)
		label.textColor = SemanticColors.Counters.newCases
		return label
	}()

	private lazy var deathsTitle = Label(style: Label.Style.subheader, text: "Умерли")

	private lazy var deathsCounter: Label = {
		let label = Label(style: Label.Style.counter)
		label.textColor = SemanticColors.Counters.newDeaths
		return label
	}()

	private lazy var rankTitle = Label(style: Label.Style.subheader, text: "Место в мире")

	private lazy var rankCounter = Label(style: Label.Style.counter)

	private lazy var statisticsTip: Label = {
		let tip = "(В скобках указано на сколько больше или меньше выявлено случаев по сравнению со вчерашним днём)"
		let label = Label(style: Label.Style.tip, text: tip)
		label.numberOfLines = 0
		label.isHidden = true
		return label
	}()

	// MARK: Initializers

	override init(frame: CGRect) {
		super.init(frame: frame)

		translatesAutoresizingMaskIntoConstraints = false
		placeSubviews()
		configureConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: UI Configuration

	private func placeSubviews() {
		addSubview(casesTitle)
		addSubview(casesCounter)
		addSubview(deathsTitle)
		addSubview(deathsCounter)
		addSubview(rankTitle)
		addSubview(rankCounter)
		addSubview(statisticsTip)
	}

	private func configureConstraints() {
		NSLayoutConstraint.activate([
			casesTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
			casesTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
			casesTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),

			casesCounter.topAnchor.constraint(equalTo: casesTitle.bottomAnchor, constant: 8.0),
			casesCounter.leftAnchor.constraint(equalTo: casesTitle.leftAnchor),
			casesCounter.rightAnchor.constraint(equalTo: casesTitle.rightAnchor),

			deathsTitle.topAnchor.constraint(equalTo: casesCounter.bottomAnchor, constant: 16.0),
			deathsTitle.leftAnchor.constraint(equalTo: casesCounter.leftAnchor),
			deathsTitle.rightAnchor.constraint(equalTo: casesCounter.rightAnchor),

			deathsCounter.topAnchor.constraint(equalTo: deathsTitle.bottomAnchor, constant: 8.0),
			deathsCounter.leftAnchor.constraint(equalTo: deathsTitle.leftAnchor),
			deathsCounter.rightAnchor.constraint(equalTo: deathsTitle.rightAnchor),

			rankTitle.topAnchor.constraint(equalTo: deathsCounter.bottomAnchor, constant: 16.0),
			rankTitle.leftAnchor.constraint(equalTo: deathsCounter.leftAnchor),
			rankTitle.rightAnchor.constraint(equalTo: deathsCounter.rightAnchor),

			rankCounter.topAnchor.constraint(equalTo: rankTitle.bottomAnchor, constant: 8.0),
			rankCounter.leftAnchor.constraint(equalTo: rankTitle.leftAnchor),
			rankCounter.rightAnchor.constraint(equalTo: rankTitle.rightAnchor),

			statisticsTip.topAnchor.constraint(greaterThanOrEqualTo: rankTitle.bottomAnchor, constant: 16.0),
			statisticsTip.leftAnchor.constraint(equalTo: rankTitle.leftAnchor),
			statisticsTip.rightAnchor.constraint(equalTo: rankTitle.rightAnchor),
			statisticsTip.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		])
	}

	private func makeDangerRankColor(rank: Int) -> UIColor {
		let redValue = (255.0 - CGFloat(rank)) / 255.0
		let greenValue = CGFloat(rank) / 255.0
		return UIColor(red: redValue, green: greenValue, blue: 0.0, alpha: 1.0)
	}

	// MARK: Public Methods

	func updateInformation(cases: Int, deaths: Int, dangerRank: Int) {
		statisticsTip.isHidden = true

		let dataMissing = cases == 0 && deaths == 0
		casesCounter.text = dataMissing ? Self.noDataPlaceholder : "\(cases)"
		casesCounter.text?.append(" 🦠")
		deathsCounter.text = dataMissing ? Self.noDataPlaceholder : "\(deaths)"
		deathsCounter.text?.append(" 🦠")
		casesCached = cases
		deathsCached = deaths

		switch dangerRank {
		case 0:
			rankCounter.text = Self.noDataPlaceholder
		case 1:
			rankCounter.text = "🥇"
		case 2:
			rankCounter.text = "🥈"
		case 3:
			rankCounter.text = "🥉"
		default:
			rankCounter.text = "\(dangerRank)"
			rankCounter.textColor = makeDangerRankColor(rank: dangerRank)
		}
	}

	func updateCountersWithDelta(yesterdaysCases: Int, yesterdaysDeaths: Int) {
		guard casesCounter.text != Self.noDataPlaceholder,
			deathsCounter.text != Self.noDataPlaceholder else { return }

		updateSuffix(of: casesCounter, casesYesterday: yesterdaysCases, casesToday: casesCached)
		updateSuffix(of: deathsCounter, casesYesterday: yesterdaysDeaths, casesToday: deathsCached)
		statisticsTip.isHidden = false
	}

	// MARK: Helpers

	private func updateSuffix(of label: Label, casesYesterday: Int, casesToday: Int) {
		let newSuffix = makeDeltaStringDesciption(casesYesterday: casesYesterday, casesToday: casesToday)
		label.text?.removeLast()
		label.text?.append(newSuffix)
	}

	private func makeDeltaStringDesciption(casesYesterday: Int, casesToday: Int) -> String {
		let delta = casesToday - casesYesterday
		if delta < 0 {
			return "(\(delta))"
		} else if delta > 0 {
			return "(+\(delta))"
		} else {
			return ""
		}
	}
}
