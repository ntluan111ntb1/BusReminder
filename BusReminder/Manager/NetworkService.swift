//
//  AlamofireNetworkService.swift
//  MySong
//
//  Created by LuanNT29 on 27/07/2023.
//

import Foundation
import OSLog
import Combine
import Alamofire

class AlamofireNetworkService {
    static let shared = AlamofireNetworkService()

    func fetchData<T: Decodable, Parameter: Encodable>(baseUrl: URL, parameters: Parameter) -> AnyPublisher<T, NetworkError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return AF.request(
            baseUrl,
            parameters: parameters,
            encoder: URLEncodedFormParameterEncoder.default
        )
        .publishDecodable(type: T.self, decoder: decoder)
        .tryMap { response in
            guard let value = response.value else {
                throw NetworkError(
                    status: 400,
                    message: "Bad Request \(response)")
            }
            return value
        }
        .mapError({ error in
            return NetworkError(
                status: 400,
                message: "Bad Request mapError \(error)")
        })
        .eraseToAnyPublisher()
    }
}
