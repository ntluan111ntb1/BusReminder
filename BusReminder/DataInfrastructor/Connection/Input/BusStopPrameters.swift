//
//  BusStopPrameters.swift
//  BusReminder
//
//  Created by Nguyễn Luân on 04/01/2024.
//

import Foundation

struct BusStopPrameters: Encodable {
    let location: String
    let keyword: String
    let radius: Int
    let key: String
}
