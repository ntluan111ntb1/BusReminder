//
//  Weather.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import Foundation

struct Weather: Decodable {
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
    }
}
