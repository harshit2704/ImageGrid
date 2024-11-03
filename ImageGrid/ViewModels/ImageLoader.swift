//
//  ImageLoader.swift
//  ImageGrid
//
//  Created by Harshit Rastogi on 02/11/24.
//

import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private let thumbnail: Thumbnail
    private let cacheManager = ImageCacheManager.shared
    private var currentTask: URLSessionDataTask?

    init(thumbnail: Thumbnail) {
        self.thumbnail = thumbnail
    }
    
    func loadImage() {
        if let cachedImage = cacheManager.getImage(forKey: thumbnail.basePath) {
            self.image = cachedImage
            return
        }
        
        guard let url = thumbnail.imageURL else {
            self.image = UIImage(systemName: "xmark.octagon")
            return
        }

        currentTask?.cancel()
        
        let request = URLRequest(url: url)
        currentTask = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            if let data = data, error == nil, let downloadedImage = UIImage(data: data) {
                self.cacheManager.saveImage(downloadedImage, forKey: self.thumbnail.basePath)
                
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            } else {
                DispatchQueue.main.async {
                    self.image = UIImage(systemName: "xmark.octagon")
                }
            }
        }
        
        currentTask?.resume()
    }
    
    func cancelLoading() {
        currentTask?.cancel()
    }
}
