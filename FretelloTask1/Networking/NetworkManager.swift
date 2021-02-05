//
//  NetworkManager.swift
//  FretelloTask1
//
//  Created by Иван Казанцев on 27.01.2021.
//

import Foundation

class NetworkManager {

    typealias completionFetchSession = ([Session]?) -> ()
    typealias completionFetchImage = (_ data: Data?) -> ()
    
    func fetchSessions(incUrl: String, completion: @escaping completionFetchSession) {
        guard let url = URL(string: incUrl) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil,
                  let data = data else {
                completion(nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                let sessionResponse = try decoder.decode(mainSession.self, from: data)
                completion(sessionResponse)
            } catch {
                print(error)
                completion(nil)
            }
        }.resume()
    
    }
    
    func fetchImage(incUrl: String, completion: @escaping completionFetchImage) {
        guard let url = URL(string: incUrl) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error fetching the Image")
                completion(nil)
            } else {
                completion(data)
            }
        }.resume()
    }
    
}
