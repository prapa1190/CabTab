//
//  CabDataViewModel.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

import UIKit

class CabDataViewModel: NSObject {
	private var apiHelper: APIHelper!
	private (set) var cabData: CabData? {
		didSet {
			self.bindCabDataViewModelToController()
		}
	}

	var bindCabDataViewModelToController: (() -> ()) = {}

	override init() {
		super.init()
		self.apiHelper = APIHelper()
		fetchCabData()
	}

	private func fetchCabData() {
		self.apiHelper.fetchCabData { (cabData) in
			self.cabData = cabData
		}
	}

	func getCabCont() -> Int {
		return cabData?.cabs?.count ?? 0
	}

	func getIDForCabForIndex(_ index: Int) -> String {
		guard let idString = cabData?.cabs?[index].id else { return "NA" }
		return "ID : \(idString)"
	}

	func getCabTypeImageForIndex(_ index: Int) -> String {
		guard let cabType = cabData?.cabs?[index].fleetType else { return "" }
		return cabType == FleetType.taxi ? "taxi" : "pool"
	}

	func getCabTypeForIndex(_ index: Int) -> String {
		guard let cabType = cabData?.cabs?[index].fleetType else { return "" }
		return cabType.rawValue.capitalized
	}

	func getCabDistanceForIndex(_ index: Int) -> String {
		guard let latitude = cabData?.cabs?[index].coordinate?.latitude, let longitude = cabData?.cabs?[index].coordinate?.longitude else { return "Distance data unavailable" }
		let distance = LocationHelper.shared.getDistanceFrom(lat: latitude, long: longitude)

		if distance < 0 {
			return "Distance data unavailable"
		}

		let distanceString = String(format: "%.2f KM Away", distance/1000)
		return distanceString
	}
}
