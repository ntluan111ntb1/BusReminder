//
//  SearchPlaceHttp.swift
//  BusReminder
//
//  Created by LuanNT29 on 18/01/2024.
//

import Foundation
import Alamofire
import Combine

final class SearchPlaceHttp {
    static let url = "https://places.googleapis.com/v1/places:searchText"
    static func getSearchPlace(parameters: SearchPlaceParameters) -> AnyPublisher<SearchPlace, NetworkError> {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "X-Goog-Api-Key", value: "AIzaSyCA7W3nxPuueYPOH-UN9MxxpeUpH4tSZgI")
        headers.add(name: "X-Goog-FieldMask", value: "places.displayName,places.formattedAddress,places.location")
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
        .flatMap { (response: SearchPlaceEntity) -> AnyPublisher<SearchPlace, NetworkError> in
            let mappedResult = SearchPlaceMapper.map(entity: response)
            return Result.Publisher(mappedResult).eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

