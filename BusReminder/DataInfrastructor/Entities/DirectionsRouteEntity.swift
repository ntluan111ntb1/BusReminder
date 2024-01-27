//
//  DirectionsRoute.swift
//  BusReminder
//
//  Created by LuanNT29 on 09/01/2024.
//

import Foundation

struct DirectionsRouteEntity: Codable {
    struct Leg: Codable {
        struct Step: Codable {
            struct Polyline: Codable {
                let encodedPolyline: String
            }

            struct Location: Codable {
                let latLng: LatLng
            }

            struct NavigationInstruction: Codable {
                let maneuver: String?
                let instructions: String
            }

            struct LocalizedValues: Codable {
                struct Distance: Codable {
                    let text: String
                }

                struct StaticDuration: Codable {
                    let text: String
                }

                let distance: Distance
                let staticDuration: StaticDuration
            }

            let distanceMeters: Int
            let staticDuration: String
            let polyline: Polyline
            let startLocation: Location
            let endLocation: Location
            let navigationInstruction: NavigationInstruction?
            let localizedValues: LocalizedValues
            let travelMode: String
        }

        struct LocalizedValues: Codable {
            struct Distance: Codable {
                let text: String
            }

            struct Duration: Codable {
                let text: String
            }

            struct StaticDuration: Codable {
                let text: String
            }

            let distance: Distance
            let duration: Duration
            let staticDuration: StaticDuration
        }

        let polyline: Step.Polyline
        let startLocation: Step.Location
        let endLocation: Step.Location
        let steps: [Step]
        let localizedValues: LocalizedValues
    }

    struct LatLng: Codable {
        let latitude: Double
        let longitude: Double
    }

    let routes: [RouteDirections]

    struct RouteDirections: Codable {
        struct Polyline: Codable {
            let encodedPolyline: String
        }

        struct TravelAdvisory: Codable {
            struct TransitFare: Codable {
                let currencyCode: String
                let units: String
            }

            let transitFare: TransitFare
        }

        struct LocalizedValues: Codable {
            struct Distance: Codable {
                let text: String
            }

            struct Duration: Codable {
                let text: String
            }

            struct StaticDuration: Codable {
                let text: String
            }

            struct TransitFare: Codable {
                let text: String
            }

            let distance: Distance
            let duration: Duration
            let staticDuration: StaticDuration
            let transitFare: TransitFare
        }

        let legs: [Leg]
        let travelAdvisory: TravelAdvisory
        let localizedValues: LocalizedValues
    }
}

