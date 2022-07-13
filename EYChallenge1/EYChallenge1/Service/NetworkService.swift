//
//  NetworkService.swift
//  EYChallenge1
//
//  Created by Stephen on 7/11/22.
//

import Foundation


struct NetworkConstants {
    static let urlS = "http://ip.jsontest.com"
}


class NetworkService {
    
    // MARK: ASYNC / AWAIT implementation
    
    static func getDataAsyncAwait<T: Decodable>() async -> T? {
        
        guard let url = URL(string: NetworkConstants.urlS) else {
            return nil
        }
        
        do {
            let response = try await URLSession.shared.data(from: url)
            let model = try JSONDecoder().decode(T.self, from: response.0)
            return model
        } catch {
            return nil
        }
        
    }
    
    
    // MARK: Closure implementation
    
    static func getDataClosure<T: Decodable>(completion: @escaping (T?) -> Void) {
        
        guard let url = URL(string: NetworkConstants.urlS) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                completion(nil)
                return
            }

            let model = try? JSONDecoder().decode(T.self, from: data)
            completion(model)
        }.resume()
    }
    
    
}
