//
//  CabTabModelTest.swift
//  CabTabTests
//
//  Created by Prasad Parab on 07/05/21.
//

import XCTest
@testable import CabTab

class CabTabModelTest: XCTestCase {
	var sut: String!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		try super.setUpWithError()
		sut = "{\"poiList\":[{\"id\":793775,\"coordinate\":{\"latitude\":18.87898010059887,\"longitude\":73.69154408107791},\"fleetType\":\"POOLING\",\"heading\":259.0769163645229},{\"id\":480234,\"coordinate\":{\"latitude\":18.654184841462033,\"longitude\":73.08894507263784},\"fleetType\":\"TAXI\",\"heading\":271.4368933665751},{\"id\":793449,\"coordinate\":{\"latitude\":18.647402955402168,\"longitude\":72.95128909644438},\"fleetType\":\"TAXI\",\"heading\":353.7206922611381}]}"

//		sut = "{\"userId\":1,\"id\":1,\"title\":\"delectus aut autem\",\"completed\":false}"
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		sut = nil
		try super.tearDownWithError()
    }

	func testCabDataJSONDataParsingCompletes() throws {
		let jsonData = sut.data(using: .utf8)
		let cabData = try CabData(data: jsonData!)
		XCTAssertNotNil(cabData.cabs, "CabData is nil, parsing failed")
	}
}
