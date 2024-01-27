//
//  SearchPlaceViewModel.swift
//  BusReminder
//
//  Created by LuanNT29 on 18/01/2024.
//

import Foundation
import Combine

final class SearchPlaceViewModel: ObservableObject {
    @Published var searchPlace = SearchPlace(places: [])
    private var disposables = Set<AnyCancellable>()
    func searchPlace(parameter: SearchPlaceParameters) {
        SearchPlaceHttp.getSearchPlace(parameters: parameter)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [self] response in
                searchPlace = response
            }
            .store(in: &disposables)
    }
}
