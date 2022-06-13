//
//  ApiManager.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 09/06/2022.
//

import Foundation
import Alamofire

struct ApiManager {
    
    
    static let shared = ApiManager()
    
    private init(){}
    
    func get(url: String,completion: @escaping (Result<Data?, AFError>) -> ()){
        
        AF.request(url, method: .get).response { response in
            completion(response.result)
        }
    

    

    }
    
}
