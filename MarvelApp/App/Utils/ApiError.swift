//
//  ApiError.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 11/06/2022.
//

import Foundation

enum ApiError {
    case noCharacterData, noEventsData
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noCharacterData : return "The Character service is not available"
        case .noEventsData : return "The Events service is not available"
        }
    }
}
