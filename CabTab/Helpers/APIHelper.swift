//
//  APIHelper.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

import UIKit

class APIHelper: NSObject {
	func fetchCabData(completion: @escaping (CabData?) -> ()) {
		let urlString = "\(apiBaseURL)?p1Lat=\(p1Lat)&p1Lon=\(p1Long)&p2Lat=\(p2Lat)&p2Lon=\(p2Long)"

		guard let url = URL(string:urlString) else {
			completion(nil)
			return
		}

		URLSession.shared.dataTask(with: url) { (responseData, reponse, error) in
			if let error = error {
				print("\(#function) : error : \(error.localizedDescription)")
				completion(nil)
			} else if let data = responseData {
				print("\(#function) : data : \(String(data: data, encoding: .utf8) ?? "[]")")
				do {
					let cabData = try CabData(data: data)
					completion(cabData)
				} catch {
					print("\(#function) : parse error : \(error.localizedDescription)")
					completion(nil)
				}
			}
		}.resume()
	}
}
