//
//  DirectionsRouteViewModel.swift
//  BusReminder
//
//  Created by LuanNT29 on 09/01/2024.
//


import Foundation
import Combine
import Alamofire
import OSLog

final class DirectionsRouteViewModel: ObservableObject {
    @Published var directionsRoute: DirectionsRoute?

    private var disposables = Set<AnyCancellable>()
    private let logger = Logger()

    func getDirectionsRoute(parameters: DirectionsRouteParameters) {
        DirectionsRouteHttp.getDirectionsRoute(parameters: parameters)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.logger.error("Error: \(error)")
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                print("==> \(response)")
                directionsRoute = response
            })
            .store(in: &disposables)
    }

    func computeRoutes() {
        let url = "https://routes.googleapis.com/directions/v2:computeRoutes"
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "X-Goog-Api-Key", value: "AIzaSyCA7W3nxPuueYPOH-UN9MxxpeUpH4tSZgI")
        headers.add(name: "X-Goog-FieldMask", value: "routes")
        do {
            let parameters = try JSONEncoder().encode(DirectionsRouteParameters())
            if let jsonString = String(data: parameters, encoding: .utf8) {
                print("Encoded Parameters: \(jsonString)")
            }
            AF.request(
                url,
                method: .post,
                parameters: DirectionsRouteParameters(),
                encoder: JSONParameterEncoder.default,
                headers: headers
            ).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Response: \(value)")
                    // Handle the response data here
                case .failure(let error):
                    print("Error: \(error)")
                    // Handle the error here
                }
            }
        } catch {
            print("Error encoding parameters: \(error)")
            // Handle the encoding error here
        }
    }
}

