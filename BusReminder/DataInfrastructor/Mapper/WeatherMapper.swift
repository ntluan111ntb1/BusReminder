//
//  WeatherMapper.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import Foundation

struct WeatherMapper {
    static func map(entity: WeatherEntity) -> Weather {
        Weather(
            weather: entity.weather.map({
                Weather.WeatherResponse(id: $0.id, main: $0.main, description: $0.description, icon: $0.icon)
            }),
            main: Weather.MainResponse(
                temp: entity.main.temp
            ),
            name: entity.name
        )
    }
}
