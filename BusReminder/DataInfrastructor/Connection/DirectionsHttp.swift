//
//  DirectionsHttp.swift
//  BusReminder
//
//  Created by LuanNT29 on 25/12/2023.
//

import Foundation
import Combine
import SwiftUI

final class DirectionsHttp {

    static let url = "https://maps.googleapis.com/maps/api/directions/json"

    static func getDirections(parameters: DirectionsPrameter) -> AnyPublisher<Directions, NetworkError> {
        guard let baseUrl = URL(string: url) else {
            return Fail(error: NetworkError(
                status: 404,
                message: "URL Invalid")
            )
            .eraseToAnyPublisher()
        }
        let param = "?mode=\(parameters.mode)&avoid=\(parameters.avoid)&origin=\(parameters.origin)&destination=\(parameters.destination)&key=\(parameters.key)"
        print("URL = \(baseUrl)\(param)")
        return AlamofireNetworkService.shared.fetchData(baseUrl: baseUrl, parameters: parameters)
            .flatMap { (response: DirectionsEntity) -> AnyPublisher<Directions, NetworkError> in
                let mappedResult = DirectionsMapper.map(entity: response)
                print("\(mappedResult)")
                return Result.Publisher(mappedResult).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
