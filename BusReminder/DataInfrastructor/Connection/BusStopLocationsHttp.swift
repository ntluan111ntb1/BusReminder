//
//  BusStopLocationsHttp.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import Foundation
import Combine

final class BusStopLocationsHttp {
    static let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

    static func getBusStopLocation(parameters: BusStopPrameters) -> AnyPublisher<BusStopLocations, NetworkError> {
        guard let baseUrl = URL(string: url) else {
            return Fail(error: NetworkError(
                status: 404,
                message: "URL Invalid")
            )
            .eraseToAnyPublisher()
        }
        let param = "?location=\(parameters.location)&keyword=\(parameters.keyword)&radius=\(parameters.radius)&key=\(parameters.key)"
        print("URL = \(baseUrl)\(param)")
        return AlamofireNetworkService.shared.fetchData(baseUrl: baseUrl, parameters: parameters)
            .flatMap { (response: BusStopLocationsEntity) -> AnyPublisher<BusStopLocations, NetworkError> in
                let mappedResult = BusStopLocationsMapper.map(entity: response)
                return Result.Publisher(mappedResult).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
