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
    @Published var isLoading = true

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
                isLoading = false
                directionsRoute = response
            })
            .store(in: &disposables)
    }
}

