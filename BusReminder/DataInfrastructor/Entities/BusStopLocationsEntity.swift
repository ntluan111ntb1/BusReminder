//
//  BusStopLocationsEntity.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import Foundation

struct LocationEntity: Decodable {
    let lat: Double
    let lng: Double
}

struct GeometryEntity: Decodable {
    let location: LocationEntity
}

struct ResultEntity: Decodable {
    let geometry: GeometryEntity
    let name: String
    let vicinity: String
}


struct BusStopLocationsEntity: Decodable {
    let results: [ResultEntity]
}
