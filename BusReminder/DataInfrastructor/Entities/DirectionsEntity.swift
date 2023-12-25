//
//  Directions.swift
//  BusReminder
//
//  Created by LuanNT29 on 25/12/2023.
//

import Foundation

struct DirectionsEntity: Codable {
    let routes: [RouteEntity]
}

struct RouteEntity: Codable {
    let legs: [LegEntity]
    let overviewPolyline: OverviewPolylineEntity
}

struct LegEntity: Codable {
    let distance: TextValueEntity
    let duration: TextValueEntity
    let endAddress: String
    let startAddress: String
    let steps: [StepEntity]
}

struct TextValueEntity: Codable {
    let text: String
    let value: Int
}

struct OverviewPolylineEntity: Codable {
    let points: String
}

struct StepEntity: Codable {
    let distance: TextValueEntity
    let duration: TextValueEntity
    let endLocation: LocationsEntity
    let htmlInstructions: String
    let maneuver: String?
    let polyline: PolylineEntity
    let startLocation: LocationsEntity
    let travelMode: String
}

struct LocationsEntity: Codable {
    let lat: Double
    let lng: Double
}

struct PolylineEntity: Codable {
    let points: String
}
