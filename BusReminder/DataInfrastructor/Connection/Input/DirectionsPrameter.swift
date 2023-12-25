//
//  DirectionsPrameter.swift
//  BusReminder
//
//  Created by LuanNT29 on 25/12/2023.
//

import Foundation

struct DirectionsPrameter: Encodable {
    let mode: String
    let avoid: String
    let origin: String
    let destination: String
    let key: String
    
    init(origin: String, destination: String) {
        self.mode = "walking"
        self.avoid = "highways"
        self.origin = origin
        self.destination = destination
        self.key = Constants.GoogleMapUrlPrams.key
    }
}
