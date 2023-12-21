//
//  BusStopLocationsMapper.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import Foundation
import GoogleMaps

struct BusStopLocationsMapper {
    static func map(entity: BusStopLocationsEntity) -> BusStopLocations {
        BusStopLocations(results: entity.results.map {
            ResultDomain(
                geometry: GeometryDomain(
                    location: CLLocationCoordinate2D(
                        latitude: $0.geometry.location.lat,
                        longitude: $0.geometry.location.lng
                    )
                ),
                address: $0.name,
                ward: $0.vicinity
            )
        })
    }
}
