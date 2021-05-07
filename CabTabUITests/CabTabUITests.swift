//
//  CabTabUITests.swift
//  CabTabUITests
//
//  Created by Prasad Parab on 05/05/21.
//

import XCTest

class CabTabUITests: XCTestCase {
	var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

		try super.setUpWithError()
		continueAfterFailure = false
		app = XCUIApplication()
		app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testListControllerIsLaunched() {
		app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element.tap()
		let title = app.navigationBars["List"].staticTexts["List"]

		XCTAssertTrue(title.exists)
	}

	func testMapControllerIsLaunched() {
		app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .button).element.tap()
		let title = app.navigationBars["Map"].staticTexts["Map"]

		XCTAssertTrue(title.exists)
	}
}
