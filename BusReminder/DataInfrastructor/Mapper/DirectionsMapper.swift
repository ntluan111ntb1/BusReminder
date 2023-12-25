//
//  DirectionsMapper.swift
//  BusReminder
//
//  Created by LuanNT29 on 25/12/2023.
//

import Foundation
import GoogleMaps

struct DirectionsMapper {
    static func map(entity: DirectionsEntity) -> Directions {
        Directions(
            routes: entity.routes.map({ route in
                Route(
                    legs: route.legs.map({
                        Leg(
                            distance: TextValue(text: $0.distance.text, value: $0.distance.value),
                            duration: TextValue(text: $0.duration.text, value: $0.duration.value),
                            endAddress: $0.endAddress,
                            startAddress: $0.startAddress,
                            steps: $0.steps.map({ step in
                                Step(
                                    distance: TextValue(text: step.distance.text, value: step.distance.value),
                                    duration: TextValue(text: step.duration.text, value: step.duration.value),
                                    endLocation: Location(lat: step.endLocation.lat, lng: step.endLocation.lng),
                                    htmlInstructions: step.htmlInstructions,
                                    maneuver: step.maneuver,
                                    polyline: Polyline(points: step.polyline.points),
                                    startLocation: Location(lat: step.startLocation.lat, lng: step.startLocation.lng),
                                    travelMode: step.travelMode
                                )
                            })
                        )
                    }),
                    overviewPolyline: OverviewPolyline(points: route.overviewPolyline.points)
                )
            })
        )
    }
}
