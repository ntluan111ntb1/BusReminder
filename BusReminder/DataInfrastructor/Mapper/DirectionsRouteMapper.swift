//
//  DirectionsRouteMapper.swift
//  BusReminder
//
//  Created by LuanNT29 on 09/01/2024.
//

import Foundation

struct DirectionsRouteMapper {
    static func map(entity: DirectionsRouteEntity) -> DirectionsRoute {
        DirectionsRoute(routes: entity.routes.map({ route in
            DirectionsRoute.RouteDirections(
                legs: route.legs.map({ leg in
                    DirectionsRoute.Leg(
                        polyline: DirectionsRoute.Leg.Step.Polyline(encodedPolyline: leg.polyline.encodedPolyline),
                        startLocation: DirectionsRoute.Leg.Step.Location(
                            latLng: DirectionsRoute.LatLng(
                                latitude: leg.startLocation.latLng.latitude,
                                longitude: leg.startLocation.latLng.longitude
                            )
                        ),
                        endLocation: DirectionsRoute.Leg.Step.Location(
                            latLng: DirectionsRoute.LatLng(
                                latitude: leg.endLocation.latLng.latitude,
                                longitude: leg.endLocation.latLng.longitude
                            )
                        ),
                        steps: leg.steps.map({ step in
                            DirectionsRoute.Leg.Step(
                                distanceMeters: step.distanceMeters,
                                staticDuration: step.staticDuration,
                                polyline: DirectionsRoute.Leg.Step.Polyline(encodedPolyline: step.polyline.encodedPolyline),
                                startLocation: DirectionsRoute.Leg.Step.Location(
                                    latLng: DirectionsRoute.LatLng(
                                        latitude: step.startLocation.latLng.latitude,
                                        longitude: step.startLocation.latLng.longitude
                                    )
                                ),
                                endLocation: DirectionsRoute.Leg.Step.Location(
                                    latLng: DirectionsRoute.LatLng(
                                        latitude: step.endLocation.latLng.latitude,
                                        longitude: step.endLocation.latLng.longitude
                                    )
                                ),
                                navigationInstruction: DirectionsRoute.Leg.Step.NavigationInstruction(
                                    maneuver: step.navigationInstruction?.maneuver ?? "",
                                    instructions: step.navigationInstruction?.instructions ?? ""
                                ),
                                localizedValues: DirectionsRoute.Leg.Step.LocalizedValues(
                                    distance: DirectionsRoute.Leg.Step.LocalizedValues.Distance(
                                        text: step.localizedValues.distance.text
                                    ),
                                    staticDuration: DirectionsRoute.Leg.Step.LocalizedValues.StaticDuration(
                                        text: step.localizedValues.staticDuration.text
                                    )
                                ),
                                travelMode: step.travelMode
                            )
                        }),
                        localizedValues: DirectionsRoute.Leg.LocalizedValues(
                            distance: DirectionsRoute.Leg.LocalizedValues.Distance(
                                text: leg.localizedValues.distance.text
                            ),
                            duration: DirectionsRoute.Leg.LocalizedValues.Duration(
                                text: leg.localizedValues.duration.text
                            ),
                            staticDuration: DirectionsRoute.Leg.LocalizedValues.StaticDuration(
                                text: leg.localizedValues.staticDuration.text
                            )
                        )
                    )
                }),
                travelAdvisory: DirectionsRoute.RouteDirections.TravelAdvisory(
                    transitFare: DirectionsRoute.RouteDirections.TravelAdvisory.TransitFare(
                        currencyCode: route.travelAdvisory.transitFare.currencyCode,
                        units: route.travelAdvisory.transitFare.units
                    )
                ),
                localizedValues: DirectionsRoute.RouteDirections.LocalizedValues(
                    distance: DirectionsRoute.RouteDirections.LocalizedValues.Distance(
                        text: route.localizedValues.distance.text
                    ),
                    duration: DirectionsRoute.RouteDirections.LocalizedValues.Duration(
                        text: route.localizedValues.duration.text
                    ),
                    staticDuration: DirectionsRoute.RouteDirections.LocalizedValues.StaticDuration(
                        text: route.localizedValues.staticDuration.text
                    ),
                    transitFare: DirectionsRoute.RouteDirections.LocalizedValues.TransitFare(
                        text: route.localizedValues.transitFare.text
                    )
                )
            )
        }))
    }
}
