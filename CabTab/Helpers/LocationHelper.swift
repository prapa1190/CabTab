//
//  LocationHelper.swift
//  CabTab
//
//  Created by Prasad Parab on 07/05/21.
//

import UIKit
import CoreLocation

class LocationHelper: NSObject {
	static let shared = LocationHelper()

	private var locationManager: CLLocationManager!
	private var currentLocation: CLLocation?

	private override init() {
		super.init()
		self.locationManager = CLLocationManager()
		self.locationManager.delegate = self
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
	}

	func requestPermission() {
		locationManager.requestAlwaysAuthorization()
	}

	func getCurrentLocation() -> CLLocation? {
		self.currentLocation
	}

	func getDistanceFrom(lat: Double, long: Double) -> Double {
		if let currentLocation = self.currentLocation {
			let location = CLLocation(latitude: lat, longitude: long)
			return currentLocation.distance(from: location)
		} else {
			return -1.0
		}
	}
}

extension LocationHelper: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedAlways || status == .authorizedWhenInUse {
			self.locationManager.startUpdatingLocation()
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let userLocation: CLLocation = locations[0]

		// Call stopUpdatingLocation() to stop listening for location updates,
		// other wise this function will be called every time when user location changes.
//		self.locationManager.stopUpdatingLocation()
		self.currentLocation = userLocation
	}
}
