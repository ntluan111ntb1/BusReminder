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

    func fetchData<T: Decodable, Parameter: Encodable>(
        baseUrl: URL,
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = nil,
        parameters: Parameter? = nil
    ) -> AnyPublisher<T, NetworkError> {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return AF.request(
            baseUrl,
            method: method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .publishDecodable(type: T.self, decoder: decoder)
        .tryMap { response in
            guard let value = response.value else {
                print("==> \(response)")
                throw NetworkError(
                    status: response.response?.statusCode ?? 400,
                    message: "Bad Request \(response)"
                )
            }
            print("Res")
            return value
        }
        .mapError({ error in
            NetworkError(
                status: 400,
                message: "Bad Request mapError \(error)"
            )
        })
        .eraseToAnyPublisher()
    }
}
