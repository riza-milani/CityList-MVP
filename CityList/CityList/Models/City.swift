//
//  City.swift
//  CityList
//
//  Created by riza milani on 5/17/1398 AP.
//  Copyright © 1398 riza milani. All rights reserved.
//

import Foundation

struct City: Codable {
    let country: String
    let name: String
    let _id: Int
    let coord: Coord
    
}
extension City {
    static func == (lhs: City, rhs: City) -> Bool {
        return true
    }
}
