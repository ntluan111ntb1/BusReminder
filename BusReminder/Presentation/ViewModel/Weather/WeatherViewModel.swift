//
//  WeatherViewModel.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import Foundation
import Combine
import OSLog

final class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    
    private var disposables = Set<AnyCancellable>()
    private let logger = Logger()
    
    func getWeather(parameters: WeatherParamters) {
        WeatherHttp.getWeather(parameters: parameters)
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
                weather = response
            })
            .store(in: &disposables)
    }
}
