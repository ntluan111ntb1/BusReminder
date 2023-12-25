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

    init() {
        self.mode = "walking"
        self.avoid = "highways"
        self.origin = "15.9804019,108.2733526"
        self.destination = "15.9804019,108.2733526"
        self.key = Constants.GoogleMapUrlPrams.key
    }
}
