//
//  ApiError.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 11/06/2022.
//

import Foundation

enum ApiError {
    case noCharacterData, noEventsData, failLogin, failSignup
}

extension ApiError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noCharacterData : return "The Character service is not available"
        case .noEventsData : return "The Events service is not available"
        case .failLogin : return "Invalid username or Password"
        case .failSignup : return "The email is already in use"
        }
    }
}
