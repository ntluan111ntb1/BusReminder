//
//  DirectionsRouteParameters.swift
//  BusReminder
//
//  Created by LuanNT29 on 09/01/2024.
//

import Foundation

struct DirectionsRouteParameters: Codable {
    struct Location: Codable {
        let location: LatLng
        
        struct LatLng: Codable {
            let latLng: Coordinate
            
            struct Coordinate: Codable {
                let latitude: Double
                let longitude: Double
            }
        }
    }

    struct TransitPreferences: Codable {
        let routingPreference: String
        let allowedTravelModes: String
    }

    let origin: Location
    let destination: Location
    let travelMode: String
    let computeAlternativeRoutes: Bool
    let transitPreferences: TransitPreferences
    let polylineQuality: String
    let polylineEncoding: String

    init(origin: Location, destination: Location) {
        self.origin = origin
        self.destination = destination
        self.travelMode = "TRANSIT"
        self.computeAlternativeRoutes = false
        self.transitPreferences = TransitPreferences(routingPreference: "LESS_WALKING", allowedTravelModes: "BUS")
        self.polylineQuality = "POLYLINE_QUALITY_UNSPECIFIED"
        self.polylineEncoding = "POLYLINE_ENCODING_UNSPECIFIED"
    }
}
