//
//  CityListPresenter.swift
//  CityListTests
//
//  Created by riza milani on 5/24/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import XCTest
@testable import CityList

class CityListPresenterTest: XCTestCase {

    var expectation = XCTestExpectation(description: "Test Fetching data")
    var presenter: CityListPresenterProtocol!
    var cities: [City] = []

    override func setUp() {
        continueAfterFailure = false
        presenter = CityListPresenter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchData() {
        presenter.fetchData { [weak self] cities in
            self?.cities = cities
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 100.0)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
