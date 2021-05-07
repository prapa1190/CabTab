//
//  CabData.swift
//  CabTab
//
//  Created by Prasad Parab on 05/05/21.
//

//   let cabData = try CabData(json)

import Foundation

// MARK: - CabData
struct CabData: Codable {
	let cabs: [Cab]?

	enum CodingKeys: String, CodingKey {
		case cabs = "poiList"
	}
}

// MARK: CabData convenience initializers and mutators

extension CabData {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(CabData.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		cabs: [Cab]?? = nil
	) -> CabData {
		return CabData(
			cabs: cabs ?? self.cabs
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// MARK: - Cab
struct Cab: Codable {
	let id: Int?
	let coordinate: Coordinate?
	let fleetType: FleetType?
	let heading: Double?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case coordinate = "coordinate"
		case fleetType = "fleetType"
		case heading = "heading"
	}
}

// MARK: PoiList convenience initializers and mutators

extension Cab {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(Cab.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		id: Int?? = nil,
		coordinate: Coordinate?? = nil,
		fleetType: FleetType?? = nil,
		heading: Double?? = nil
	) -> Cab {
		return Cab(
			id: id ?? self.id,
			coordinate: coordinate ?? self.coordinate,
			fleetType: fleetType ?? self.fleetType,
			heading: heading ?? self.heading
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// MARK: - Coordinate
struct Coordinate: Codable {
	let latitude: Double?
	let longitude: Double?

	enum CodingKeys: String, CodingKey {
		case latitude = "latitude"
		case longitude = "longitude"
	}
}

// MARK: Coordinate convenience initializers and mutators

extension Coordinate {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(Coordinate.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		latitude: Double?? = nil,
		longitude: Double?? = nil
	) -> Coordinate {
		return Coordinate(
			latitude: latitude ?? self.latitude,
			longitude: longitude ?? self.longitude
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

enum FleetType: String, Codable {
	case pooling = "POOLING"
	case taxi = "TAXI"
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
	let decoder = JSONDecoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		decoder.dateDecodingStrategy = .iso8601
	}
	return decoder
}

func newJSONEncoder() -> JSONEncoder {
	let encoder = JSONEncoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		encoder.dateEncodingStrategy = .iso8601
	}
	return encoder
}

