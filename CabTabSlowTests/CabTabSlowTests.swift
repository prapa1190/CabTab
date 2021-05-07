//
//  CabTabSlowTests.swift
//  CabTabSlowTests
//
//  Created by Prasad Parab on 07/05/21.
//

import XCTest
@testable import CabTab

class CabTabSlowTests: XCTestCase {
	var sut: URLSession!
	let monitor = NetworkMonitor.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
		try super.setUpWithError()
		sut = URLSession.shared
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
		sut = nil
		try super.tearDownWithError()
    }

	func testCabAPICallCompletes() throws {
		try XCTSkipUnless(monitor.isReachable, "Network connectivity needed")

		let urlString = "\(apiBaseURL)?p1Lat=\(p1Lat)&p1Lon=\(p1Long)&p2Lat=\(p2Lat)&p2Lon=\(p2Long)"
		let url = URL(string: urlString)!
		let promise = expectation(description: "Completion handler invoked")
		var statusCode: Int?
		var responseError: Error?

		let dataTask = sut.dataTask(with: url) { _, response, error in
			statusCode = (response as? HTTPURLResponse)?.statusCode
			responseError = error
			promise.fulfill()
		}
		dataTask.resume()
		wait(for: [promise], timeout: 5)

		XCTAssertNil(responseError)
		XCTAssertEqual(statusCode, 200)
	}
}
