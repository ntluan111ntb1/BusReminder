//
//  SearchPlaceMapper.swift
//  BusReminder
//
//  Created by LuanNT29 on 18/01/2024.
//

import Foundation

struct SearchPlaceMapper: Encodable {
    static func map(entity: SearchPlaceEntity) -> SearchPlace {
        SearchPlace(
            places: entity.places.map({ place in
                SearchPlace.Place(
                    formattedAddress: place.formattedAddress,
                    location: SearchPlace.Place.Location(
                        latitude: place.location.latitude,
                        longitude: place.location.longitude
                    ),
                    displayName: SearchPlace.Place.DisplayName(text: place.displayName.text)
                )
            })
        )
    }
}
