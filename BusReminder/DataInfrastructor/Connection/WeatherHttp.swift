//
//  WeatherHttp.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import Foundation
import Combine

final class WeatherHttp {

    static let url = "https://api.openweathermap.org/data/2.5/weather?appid=48532a5e16bd27acbb55cf0c9b778afc&units=metric"

    static func getDirections(parameters: WeatherParamters) -> AnyPublisher<Weather, NetworkError> {
        guard let baseUrl = URL(string: url) else {
            return Fail(error: NetworkError(
                status: 404,
                message: "URL Invalid")
            )
            .eraseToAnyPublisher()
        }
        let param = "lat=\(parameters.lat)&lon=\(parameters.lon)"
        print("URL = \(baseUrl)\(param)")
        return AlamofireNetworkService.shared.fetchData(baseUrl: baseUrl, parameters: parameters)
            .flatMap { (response: WeatherEntity) -> AnyPublisher<Weather, NetworkError> in
                let mappedResult = WeatherMapper.map(entity: response)
                print("\(mappedResult)")
                return Result.Publisher(mappedResult).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
