//
//  EventsService.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 11/06/2022.
//

import Foundation
import Alamofire

protocol EventsFetching{
    func fetchEvent(onComplete: @escaping (CharacterResponse) ->(), onError: @escaping (String) ->())
}

struct EventsService: EventsFetching {
    
    private let baseURL = "https://gateway.marvel.com/v1/public/events"
    private let apiKey = "f161a8fc551c04c58ce8415ca5590985"
    private let hash = "5cc8fb010118e81c8e61c46d129d8f1a"

    
    static let shared = CharacterService()
    
    func fetchEvent(onComplete: @escaping (CharacterResponse) ->(), onError: @escaping (String) ->()){
        
        let url = baseURL + buildQueryString()

        
        ApiManager.shared.get(url: "\(url)") { response in
            switch response {
            case .success(let data):
                do{
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(CharacterResponse.self, from: data)
                        onComplete(response)
                    }else {
                        onError(ApiError.noEventsData.errorDescription!)
                    }
                }catch{
                    onError(ApiError.noEventsData.errorDescription!)
                }
            case .failure(_):
                onError(ApiError.noEventsData.errorDescription!)
            }
        }
    }
    
    private func buildQueryString() -> String{
        
        let queryString = "?apikey=\(apiKey)&hash=\(hash)&ts=1"
        return queryString
    }
}

