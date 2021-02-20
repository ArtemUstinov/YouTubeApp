//
//  UIImageView +.swift
//  YouTubeApp
//
//  Created by Артём Устинов on 16.02.2021.
//  Copyright © 2021 Artem Ustinov. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    private var customImageViewModel = CustomImageViewModel()
    
    func loadImage(from urlString: String) {
        
        if let cachedImage =
            customImageViewModel.getCachedImage(from: urlString) {
            image = cachedImage
            return
        }
        
        customImageViewModel.fetchImageData(from: urlString) {
            [weak self] imageData in
            DispatchQueue.main.async {
                self?.image = UIImage(data: imageData)
            }
        }
    }
}




