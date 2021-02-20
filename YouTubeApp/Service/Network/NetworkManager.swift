//
//  NetworkManager.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 16.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    enum Api: String {
        case home =
                "https://s3-us-west-2.amazonaws.com/youtubeassets/home_num_likes.json"
        case trending =
                "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        case subscription =
                "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
    }
    
    //MARK: - Public methods:
    func fetchVideo(url: Api,
                    completion: @escaping([Video]) -> Void) {
        
        guard let url = URL(string: url.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let jsonData = try JSONDecoder().decode([Video].self,
                                                        from: data)
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchDataImage(from urlString: String,
                        completion: @escaping(Data, URLResponse) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data,
                  let response = response else { return }
            completion(data, response)
        }.resume()
    }
}
