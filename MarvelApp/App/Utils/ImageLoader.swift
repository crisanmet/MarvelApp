//
//  ImageLoader.swift
//  MarvelApp
//
//  Created by Cristian Sancricca on 21/06/2022.
//

import UIKit

class ImageLoader {
   var loadedImages = [URL: UIImage]()
   var runningRequests = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {

      
      if let image = loadedImages[url] {
        completion(.success(image))
        return nil
      }

      let uuid = UUID()

      let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        defer {self.runningRequests.removeValue(forKey: uuid) }

        
        if let data = data, let image = UIImage(data: data) {
          self.loadedImages[url] = image
          completion(.success(image))
          return
        }

    
        guard let error = error else {
          
          return
        }

        guard (error as NSError).code == NSURLErrorCancelled else {
          completion(.failure(error))
          return
        }

        
      }
      task.resume()

    
      runningRequests[uuid] = task
      return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
      runningRequests[uuid]?.cancel()
      runningRequests.removeValue(forKey: uuid)
    }
    
}
