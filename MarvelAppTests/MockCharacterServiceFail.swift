//
//  MockCharacterServiceFail.swift
//  MarvelAppTests
//
//  Created by Cristian Sancricca on 14/06/2022.
//

import Foundation
@testable import MarvelApp

class MockCharacterServiceFail: CharacterFetching{
    func fetchCharacter(pageNumber: Int, onComplete: @escaping (CharacterResponse) -> (), onError: @escaping (String) -> ()) {
        onError(ApiError.noCharacterData.errorDescription!)
    }
    
    
}
