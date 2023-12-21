//
//  BusStopLocationsHttp.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import Foundation
import Combine
struct BusStopPrameters: Encodable {
    let location: String
    let keyword: String
    let radius: Int
    let key: String
}
final class BusStopLocationsHttp {
    static let prameters = BusStopPrameters(
        location: "16.048885997815244,108.18646274789408",
        keyword: "bus",
        radius: 1500,
        key: "AIzaSyBzXKSCi5fvi6ha15YDS8eyIz0jfMnsGX8"
    )
    static let url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"

    static func getBusStopLocation(parameters: BusStopPrameters) -> AnyPublisher<BusStopLocations, NetworkError> {
        guard let baseUrl = URL(string: url) else {
            return Fail(error: NetworkError(
                status: 404,
                message: "URL Invalid")
            )
            .eraseToAnyPublisher()
        }

        return AlamofireNetworkService.shared.fetchData(baseUrl: baseUrl, paramters: parameters)
            .flatMap { (response: BusStopLocationsEntity) -> AnyPublisher<BusStopLocations, NetworkError> in
                let mappedResult = BusStopLocationsMapper.map(entity: response)
                return Result.Publisher(mappedResult).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
