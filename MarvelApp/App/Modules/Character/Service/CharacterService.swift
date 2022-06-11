//
//  CharacterService.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 09/06/2022.
//

import Foundation
import Alamofire

protocol CharacterFetching{
    func fetchCharacter(onComplete: @escaping (CharacterResponse) ->(), onError: @escaping (String) ->())
}

struct CharacterService: CharacterFetching {
    
    private let baseURL = ProcessInfo.processInfo.environment["characterURL"]!
    private let apiKey = ProcessInfo.processInfo.environment["apiKey"]!
    private let hash = ProcessInfo.processInfo.environment["hash"]!

    
    static let shared = CharacterService()
    
    func fetchCharacter(onComplete: @escaping (CharacterResponse) ->(), onError: @escaping (String) ->()){
        
        let params: Parameters = ["apikey": apiKey,
                                  "hash": hash,
                                  "ts": 1,
                                  "limit": 15
        ]
        
        ApiManager.shared.get(url: "\(baseURL)", params: params) { response in
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
    
    
}
