//
//  DirectionsRouteHttp.swift
//  BusReminder
//
//  Created by LuanNT29 on 09/01/2024.
//

import Foundation
import Alamofire
import Combine

final class DirectionsRouteHttp {
    static let url = "https://routes.googleapis.com/directions/v2:computeRoutes"
    static func getDirectionsRoute(parameters: DirectionsRouteParameters) -> AnyPublisher<DirectionsRoute, NetworkError> {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "X-Goog-Api-Key", value: "AIzaSyCA7W3nxPuueYPOH-UN9MxxpeUpH4tSZgI")
        headers.add(name: "X-Goog-FieldMask", value: "routes")
        guard let baseUrl = URL(string: url) else {
            return Fail(error: NetworkError(
                status: 404,
                message: "URL Invalid")
            )
            .eraseToAnyPublisher()
        }

        return AlamofireNetworkService.shared.fetchData(
            baseUrl: baseUrl,
            method: .post,
            headers: headers, 
            parameters: parameters
        )
        .flatMap { (response: DirectionsRouteEntity) -> AnyPublisher<DirectionsRoute, NetworkError> in
            let mappedResult = DirectionsRouteMapper.map(entity: response)
            return Result.Publisher(mappedResult).eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
