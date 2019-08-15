//
//  CityListPresenter.swift
//  CityList
//
//  Created by riza milani on 5/18/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import Foundation

protocol CityListPresenterProtocol: class {
    var router: CityListRouter? { get set }
    func filterCity(startWith: String, compeletion: @escaping (([City]) -> Void))
    func showAboutInfo()
    func showMap(coord: Coord)
    func fetchData(compeletion: @escaping (([City]) -> Void))
}

class CityListPresenter: CityListPresenterProtocol {

    var router: CityListRouter?
    var citiesDictionary: [Character: [City]] = [:]
    var allSortedCities: [City] = []
    /// Searched text used to handle correct order in filter city method.
    /// without this, when user typed fast, results may not be in correct order.
    var searchedText = ""

    func fetchData(compeletion: @escaping (([City]) -> Void)) {
        let filePath = Bundle.main.path(forResource: "cities", ofType: "json")
        DispatchQueue.global(qos: .userInitiated).async {
            guard
                let path = filePath,
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                let cities = try? JSONDecoder().decode([City].self, from: data)
                else {
                    compeletion([])
                    return
            }
            self.allSortedCities = cities.sorted { $0.name < $1.name }
            cities.forEach { city in
                if let firstLetter = city.name.lowercased().first {
                    if self.citiesDictionary[firstLetter]?.isEmpty ?? true {
                        self.citiesDictionary[firstLetter] = [city]
                    }  else {
                        self.citiesDictionary[firstLetter]?.append(city)
                    }
                }
            }
            compeletion(cities)
        }
    }

    func filterCity(startWith: String, compeletion: @escaping (([City]) -> Void)) {

        searchedText = startWith
        DispatchQueue.global(qos: .userInteractive).async {

            var result: [City] = []

            if self.citiesDictionary.isEmpty {
                return
            } else if startWith.isEmpty {

                result = self.allSortedCities

            } else if let firstLetter = startWith.lowercased().first,
                let groupCities = self.citiesDictionary[firstLetter] {

                let cities = groupCities.filter {
                    $0.name.lowercased().starts(with: startWith.lowercased())
                    }.sorted { $0.name < $1.name }
                result = cities

            } else {

                result = []

            }
            // If condition false, cancle old request.
            // by checking current search bar string and filtered one.
            if self.searchedText == startWith {
                compeletion(result)
            }
        
        }
    }

    /// Navigate to about info page
    func showAboutInfo() {
        router?.showAboutInfo()
    }

    /// Navigate to map kit view controller (CityMapViewController)
    func showMap(coord: Coord) {
        router?.showMap(coord: coord)
    }
}
