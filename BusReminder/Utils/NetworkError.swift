//
//  NetworkError.swift
//  Locations
//
//  Created by LuanNT29 on 20/12/2023.
//

import Foundation

public struct NetworkError: Error {
    let status: Int
    let message: String
}

