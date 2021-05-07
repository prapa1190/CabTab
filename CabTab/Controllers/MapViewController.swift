//
//  MapViewController.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
	@IBOutlet weak var zoomOutButton: UIButton!
	private var mapView: GMSMapView!
	private var cabDataViewModel: CabDataViewModel!
	private var isDragging = false
	private var isMarkerZoomed = false {
		didSet {
			zoomOutButton.alpha = isMarkerZoomed ? 1 : 0
		}
	}
	private var latestCameraPosition: GMSCameraPosition?
	private var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.title = "Map"

		activityIndicator = UIActivityIndicatorView(style: traitCollection.userInterfaceStyle == .light ? .gray : .white)
		activityIndicator.hidesWhenStopped = true
		let barButton = UIBarButtonItem(customView: activityIndicator)
		self.navigationItem.setRightBarButton(barButton, animated: true)

		addMapView()
		zoomOutButton.alpha = 0
		zoomOutButton.layer.cornerRadius = 22
		callViewModelForUIUpdate()
    }

	func addMapView() {
		var camera: GMSCameraPosition

		if let currentPosition = LocationHelper.shared.getCurrentLocation() {
			let lat = currentPosition.coordinate.latitude
			let long = currentPosition.coordinate.longitude
			camera = GMSCameraPosition.camera(withLatitude:lat, longitude: long, zoom: 2.0)
		} else {
			camera = GMSCameraPosition()
		}

		mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
		mapView.delegate = self
		mapView.isMyLocationEnabled = true
		mapView.settings.compassButton = true
		
		self.view.addSubview(mapView)
		self.view.sendSubviewToBack(mapView)

		mapView.animate(with: GMSCameraUpdate.fit(GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: p1Lat, longitude: p1Long), coordinate: CLLocationCoordinate2D(latitude: p2Lat, longitude: p2Long))))
	}

	func callViewModelForUIUpdate() {
		activityIndicator.startAnimating()
		cabDataViewModel = CabDataViewModel()
		cabDataViewModel.bindCabDataViewModelToController = { [unowned self] in
			DispatchQueue.main.async {
				self.activityIndicator.stopAnimating()
				self.AddMarkersToMapView()
			}
		}
	}

	func AddMarkersToMapView() {
		mapView.clear()

		let markerCount = cabDataViewModel.getCabCont()

		for index in 0..<markerCount {
			guard let position = cabDataViewModel.getCabLocation(index) else { continue }

			let marker = GMSMarker()
			marker.position = position
			marker.title = cabDataViewModel.getCabTypeForIndex(index)
			marker.snippet = cabDataViewModel.getIDForCabForIndex(index)
			marker.rotation = cabDataViewModel.getCabHeading(index)
			marker.icon = UIImage(named: cabDataViewModel.getCabTypeMapIconForIndex(index))
			marker.map = mapView
		}
	}

	@IBAction func zoomOutTapped(_ sender: UIButton) {
		if let position = latestCameraPosition, isMarkerZoomed {
			isMarkerZoomed = false
			mapView.selectedMarker = nil
			mapView.animate(to: position)
		}
	}

	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	deinit {
		mapView = nil
		cabDataViewModel = nil
		latestCameraPosition = nil
		activityIndicator = nil
	}
}

extension MapViewController: GMSMapViewDelegate {
	func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
		isDragging = gesture
		if isDragging && isMarkerZoomed {
			isMarkerZoomed = false
		}
	}

	func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {

	}

	func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
		if isDragging {
			isDragging = false
			activityIndicator.startAnimating()
			cabDataViewModel.fetchCabDataFor(p1latitude: p1Lat, p1longitude: p1Long, p2latitude: position.target.latitude, p2longitude: position.target.longitude)
		}
	}

	func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
		latestCameraPosition = isMarkerZoomed ? latestCameraPosition : mapView.camera

		let zoomLevel = isMarkerZoomed ? mapView.camera.zoom : mapView.camera.zoom + 2
		let cameraPosition = GMSCameraPosition(latitude: marker.position.latitude, longitude: marker.position.longitude, zoom: zoomLevel)

		mapView.animate(to: cameraPosition)
		mapView.selectedMarker = marker

		if !isMarkerZoomed {
			isMarkerZoomed = true
		}
		return true
	}
}
