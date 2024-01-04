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
            coord: Weather.CoordinatesResponse(lon: entity.coord.lon, lat: entity.coord.lat),
            weather: entity.weather.map({
                Weather.WeatherResponse(id: $0.id, main: $0.main, description: $0.description, icon: $0.icon)
            }),
            main: Weather.MainResponse(
                temp: entity.main.temp,
                feels_like: entity.main.feels_like,
                temp_min: entity.main.temp_min,
                temp_max: entity.main.temp_max,
                pressure: entity.main.pressure,
                humidity: entity.main.humidity
            ),
            name: entity.name,
            wind: Weather.WindResponse(speed: entity.wind.speed, deg: entity.wind.deg)
        )
    }
}
