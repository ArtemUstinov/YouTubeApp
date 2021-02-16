//
//  CustomImageViewModel.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 16.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class CustomImageViewModel {
    
    //MARK: - Properties:
    private let networkManager = NetworkManager()
    
    //MARK: - Public methods:
    func fetchImageData(from urlString: String,
                        completion: @escaping(Data) -> Void) {
        networkManager.fetchDataImage(from: urlString) {
            [weak self] (imageData, response) in
            completion(imageData)
            self?.saveImageToCache(from: imageData, and: response)
        }
    }
    
    func getCachedImage(from urlString: String) -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        let urlRequest = URLRequest(url: url)
        if let cachedResponse =
            URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    //MARK: - Private methods:
    private func saveImageToCache(from data: Data,
                                  and response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let urlRequest = URLRequest(url: urlResponse)
        let cachedResponse = CachedURLResponse(response: response,
                                               data: data)
        URLCache.shared.storeCachedResponse(cachedResponse,
                                            for: urlRequest)
    }
}
