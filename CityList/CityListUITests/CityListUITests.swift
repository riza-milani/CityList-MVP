//
//  CityListUITests.swift
//  CityListUITests
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import XCTest

class CityListUITests: XCTestCase {

    var app: XCUIApplication!
    var timer: NSDate!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testExample() {
        // Wait until data prepared
        waitToLoad()
        //sleep(10)
        // Tap the search bar
        app.searchFields.firstMatch.tap()
        // After search bar focused, Type some letters (e.g. "amster")
        app.searchFields.firstMatch.typeText("amster")
        // After typing, select info button to navigate about view controller (information screen)
        app.buttons["i"].firstMatch.tap()
        // After loading information screen, check labels are loaded and existed! (or some of them)
        XCTAssertTrue(app.staticTexts["Name"].exists)
        XCTAssertTrue(app.staticTexts["Address"].exists)
        XCTAssertTrue(app.staticTexts["Postal Code"].exists)
        XCTAssertTrue(app.staticTexts["City"].exists)
        XCTAssertTrue(app.staticTexts["Details"].exists)

    }

    func waitToLoad() {
        timer = NSDate()
        while timer.timeIntervalSinceNow > -60 {
            if app.searchFields.firstMatch.placeholderValue?.contains("Filter cities by name") ?? false {
                break
            }
            // wait 60 secs or die (I mean XCTFail) ...
        }
        if !(app.searchFields.firstMatch.placeholderValue?.contains("Filter cities by name") ?? true) {
            //
            XCTFail()
        }
    }
}
