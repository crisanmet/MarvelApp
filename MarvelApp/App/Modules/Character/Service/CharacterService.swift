//
//  CharacterService.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 09/06/2022.
//

import Foundation
import Alamofire

protocol CharacterFetching{
    func fetchCharacter(pageNumber: Int, onComplete: @escaping (CharacterResponse) ->(), onError: @escaping (String) ->())
}

struct CharacterService: CharacterFetching {
    
    private let baseURL = ProcessInfo.processInfo.environment["characterURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    private let hash = ProcessInfo.processInfo.environment["hash"]!
    private var limit = 15

    
    static let shared = CharacterService()
    
    func fetchCharacter(pageNumber: Int = 1 , onComplete: @escaping (CharacterResponse) ->(), onError: @escaping (String) ->()){
     
        let url = baseURL + buildQueryString(pageNumber: pageNumber, shouldPage: true)

        ApiManager.shared.get(url: "\(url)") { response in
            switch response {
            case .success(let data):
                do{
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(CharacterResponse.self, from: data)
                        onComplete(response)
                    }else {
                        onError(ApiError.noCharacterData.errorDescription!)
                    }
                }catch{
                    onError(ApiError.noCharacterData.errorDescription!)
                }
            case .failure(_):
                onError(ApiError.noCharacterData.errorDescription!)
            }
        }
    }
    
    private func buildQueryString(pageNumber: Int = 1, shouldPage: Bool = false) -> String{
        
        var queryString = "?apikey=\(apiKey)&hash=\(hash)&ts=1"
       
        if shouldPage{
            let offset = limit * pageNumber
            queryString = queryString + "&offset=\(offset)&limit=\(limit)"
            print(queryString)
        }
        return queryString
    }
    
    
}
