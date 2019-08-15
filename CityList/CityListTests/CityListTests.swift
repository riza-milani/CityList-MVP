//
//  CityListTests.swift
//  CityListTests
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import XCTest
@testable import CityList

class CityListTests: XCTestCase {

    var expectation = XCTestExpectation(description: "Test Fetching data")
    var presenter: CityListPresenterProtocol!
    var cities: [City] = []

    override func setUp() {

        continueAfterFailure = false
        presenter = CityListPresenter()
        presenter.fetchData { [weak self] cities in
            self?.cities = cities
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 100.0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSearchFilterEmpty() {
        expectation = XCTestExpectation(description: "Test filter empty, result is all cities")
        filter(string: "")
        wait(for: [expectation], timeout: 100.0)

        XCTAssertEqual(cities.count, 209557)
    }

    func testSearchFilterHaarlem() {
        expectation = XCTestExpectation(description: "Test filter Haar with 8 results")
        filter(string: "Haar")
        wait(for: [expectation], timeout: 100.0)

        XCTAssertEqual(cities.count, 8)

        for city in cities {
            XCTAssert(city.country == "NL" || city.country == "DE" || city.country == "FI" , "Country code is \(city.country)")
        }
    }

    func testSearchFilterTehran() {
        expectation = XCTestExpectation(description: "Test filter tehran with one result")
        filter(string: "tehran")
        wait(for: [expectation], timeout: 100.0)

        XCTAssertEqual(cities.count, 1)

        XCTAssertEqual(cities[0].country, "IR")
        XCTAssertEqual(cities[0]._id, 112931)
    }

    func testSearchFilterNumbers() {
        for index in 0...9 {
            expectation = XCTestExpectation(description: "Test filter for numbers but 6")
            filter(string: "\(index)")
            wait(for: [expectation], timeout: 100.0)

            if index == 6 {
                XCTAssertEqual(cities.count, 1)
            } else {
                XCTAssertEqual(cities.count, 0)
            }
        }
    }

    func testSearchFilterSpaceDot() {
        expectation = XCTestExpectation(description: "Test filter for '[spase][dot]]'")
        filter(string: " .")
        wait(for: [expectation], timeout: 100.0)

        XCTAssertEqual(cities.count, 0)
    }
}

extension CityListTests {
    func filter(string: String) {
        presenter.filterCity(startWith: string) { [weak self] cities in
            self?.cities = cities
            self?.expectation.fulfill()
        }
    }
}
