//
//  WeatherParamters.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import Foundation

struct WeatherParamters: Encodable {
    let appid: String
    let units: String
    let lat: String
    let lon: String
    
    init(lat: String, lon: String) {
        self.appid = "48532a5e16bd27acbb55cf0c9b778afc"
        self.units = "metric"
        self.lat = lat
        self.lon = lon
    }
}
