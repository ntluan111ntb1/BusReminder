//
//  NetwordService.swift
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

    func fetchData<T: Decodable, Parameter: Encodable>(baseUrl: URL, paramters: Parameter) -> AnyPublisher<T, NetworkError> {
        return AF.request(baseUrl, parameters: paramters)
            .publishDecodable(type: T.self)
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
