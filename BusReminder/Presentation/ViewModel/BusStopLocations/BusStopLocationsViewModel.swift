//
//  BusStopLocationsViewModel.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import Foundation
import Combine
import OSLog

final class BusStopLocationsViewModel: ObservableObject {
    @Published var busStopLocations = BusStopLocations(results: [])
    @Published var isLoadMore = true

    private var disposables = Set<AnyCancellable>()
    private let logger = Logger()

    func getBusStopLocations(parameters: BusStopPrameters) {
        BusStopLocationsHttp.getBusStopLocation(parameters: parameters)
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
                self.busStopLocations.results.append(contentsOf: response.results)
                isLoadMore = false
            })
            .store(in: &disposables)
    }
}
