//
//  Cities.swift
//  Clear Air
//
//  Created by Piotr Kupczyk on 23.02.2018.
//  Copyright © 2018 Piotr Kupczyk. All rights reserved.
//

import Foundation

struct City:Decodable {
    let id:Int
    let stationName:String
    let gegrLat:String
    let gegrLon:String
    let city:Details?
    let addressStreet: String?
}

struct Details:Decodable {
    let id:Int
    let name:String
}
