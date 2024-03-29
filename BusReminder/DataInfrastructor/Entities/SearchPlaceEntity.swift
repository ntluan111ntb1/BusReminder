//
//  SearchPlaceEntity.swift
//  BusReminder
//
//  Created by LuanNT29 on 18/01/2024.
//

import Foundation

struct SearchPlaceEntity: Codable {
    let places: [Place]
    struct Place: Codable {
        let formattedAddress: String
        let location: Location
        let displayName: DisplayName

        struct Location: Codable {
            let latitude: Double
            let longitude: Double
        }

        struct DisplayName: Codable {
            let text: String
        }
    }
}
