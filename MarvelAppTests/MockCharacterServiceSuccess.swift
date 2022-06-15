//
//  MockCharacterServiceSuccess.swift
//  MarvelAppTests
//
//  Created by Cristian Sancricca on 14/06/2022.
//

import Foundation
@testable import MarvelApp

class MockCharacterServiceSuccess: CharacterFetching{
    func fetchCharacter(pageNumber: Int, onComplete: @escaping (CharacterResponse) -> (), onError: @escaping (String) -> ()) {
                let url = Bundle.main.url(forResource: "Mock", withExtension: "json")
                print(url)
                do{
                    let decoder = JSONDecoder()
                    let jsonData = try Data(contentsOf: url!)
                    let model = try decoder.decode(CharacterResponse.self, from: jsonData)
                    onComplete(model)
                } catch{
                    onError("")
                }
        
    }
    
    
    
    
    
//    func fetchNews(onComplete: @escaping ([News]) -> (), onError: @escaping (String) -> ()) {
//
//        let url = Bundle.main.url(forResource: "NewsMock", withExtension: "json")
//        print(url)
//        do{
//            let decoder = JSONDecoder()
//            let jsonData = try Data(contentsOf: url!)
//            let model = try decoder.decode(NewsResponse.self, from: jsonData)
//            onComplete(model.data)
//        } catch{
//            onError("")
//        }
//
//
//
//    }
}
