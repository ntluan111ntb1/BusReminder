//
//  Directions.swift
//  BusReminder
//
//  Created by LuanNT29 on 25/12/2023.
//

import Foundation

struct Directions: Codable {
    var routes: [Route]
}

struct Route: Codable {
    var legs: [Leg]
}

struct Leg: Codable {
    let distance: TextValue
    let duration: TextValue
    let endAddress: String
    let startAddress: String
    let steps: [Step]
}

struct TextValue: Codable {
    let text: String
    let value: Int
}

struct Step: Codable {
    let distance: TextValue
    let duration: TextValue
    let endLocation: Location
    let htmlInstructions: String
    let maneuver: String?
    let polyline: Polyline
    let startLocation: Location
    let travelMode: String
}

struct Location: Codable {
    let lat: Double
    let lng: Double
}

struct Polyline: Codable {
    let points: String
}

