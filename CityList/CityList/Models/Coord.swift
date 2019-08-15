//
//  Coord.swift
//  CityList
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import Foundation

struct Coord: Codable {
    let lon: Double
    let lat: Double
}
extension Coord {
    static func == (lhs: Coord, rhs: Coord) -> Bool {
        return true
    }
}
