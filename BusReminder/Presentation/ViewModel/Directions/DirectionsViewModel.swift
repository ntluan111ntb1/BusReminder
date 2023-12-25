//
//  DirectionsViewModel.swift
//  BusReminder
//
//  Created by LuanNT29 on 25/12/2023.
//

import Foundation
import Combine
import OSLog

final class DirectionsViewModel: ObservableObject {
    @Published var directions = Directions(routes: [])

    private var disposables = Set<AnyCancellable>()
    private let logger = Logger()

    func getDirections(parameters: DirectionsPrameter) {
        DirectionsHttp.getDirections(parameters: parameters)
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
                self.directions.routes.append(contentsOf: response.routes)
            })
            .store(in: &disposables)
    }
}
