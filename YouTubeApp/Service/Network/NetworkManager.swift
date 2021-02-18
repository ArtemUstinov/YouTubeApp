//
//  NetworkManager.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 16.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private enum Api: String {
        case youtube = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
    }
    
    func fetchVideo(completion: @escaping([Video]) -> Void) {
        guard let url = URL(string: Api.youtube.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
                let jsonData =
                    try JSONSerialization.jsonObject(with: data,
                                                     options: .mutableContainers)
                
                var channel = Channel()
                var video = Video()
                var videos = [Video]()
                
                for dictionary in jsonData as! [[String: AnyObject]] {
                    
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName =
                        dictionary["thumbnail_image_name"] as? String
                    
                    let dictionaryChannel =
                        dictionary["channel"] as? [String: AnyObject]
                    
                    channel.profileImageName =
                        dictionaryChannel?["profile_image_name"] as? String
                    channel.name = dictionaryChannel?["name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                }
                DispatchQueue.main.async {
                    completion(videos)
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
