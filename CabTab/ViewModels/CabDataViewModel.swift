//
//  CabDataViewModel.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

import UIKit
import CoreLocation

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
		self.apiHelper.fetchCabData { [unowned self] (cabData) in
			self.cabData = cabData
		}
	}

	func fetchCabDataFor(p1latitude: Double, p1longitude: Double, p2latitude: Double, p2longitude: Double) {
		self.apiHelper.fetchCabData(p1latitude: p1latitude, p1longitude: p1longitude, p2latitude: p2latitude, p2longitude: p2longitude) { [unowned self] (cabData) in
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
		guard let latitude = cabData?.cabs?[index].coordinate?.latitude,
			  let longitude = cabData?.cabs?[index].coordinate?.longitude,
			  let distance = LocationHelper.shared.getDistanceFrom(lat: latitude, long: longitude) else { return "Distance data unavailable" }

		let distanceString = String(format: "%.2f KM Away", distance/1000)
		return distanceString
	}

	func getCabLocation(_ index: Int) -> CLLocationCoordinate2D? {
		guard let latitude = cabData?.cabs?[index].coordinate?.latitude, let longitude = cabData?.cabs?[index].coordinate?.longitude else { return nil }
		return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
	}

	func getCabHeading(_ index: Int) -> Double {
		cabData?.cabs?[index].heading ?? 0
	}

	func getCabTypeMapIconForIndex(_ index: Int) -> String {
		guard let cabType = cabData?.cabs?[index].fleetType else { return "" }
		return cabType == FleetType.taxi ? "mapTaxi" : "mapPool"
	}

	deinit {
		apiHelper = nil
		cabData = nil
		bindCabDataViewModelToController = {}
	}
}
