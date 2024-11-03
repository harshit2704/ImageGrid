//
//  ImageCacheManager.swift
//  ImageGrid
//
//  Created by Harshit Rastogi on 02/11/24.
//

import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private var memoryCache = [String: UIImage]()
    private let fileManager = FileManager.default
    private let diskCacheURL: URL

    private init() {
        let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        diskCacheURL = cachesDirectory.appendingPathComponent("ManualImageCache", isDirectory: true)

        if !fileManager.fileExists(atPath: diskCacheURL.path) {
            try? fileManager.createDirectory(at: diskCacheURL, withIntermediateDirectories: true)
        }
    }
    
    func getImage(forKey key: String) -> UIImage? {
        if let image = memoryCache[key] {
            return image
        }
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        if let image = UIImage(contentsOfFile: filePath.path) {
            memoryCache[key] = image
            return image
        }
        
        return nil
    }
    
    func saveImage(_ image: UIImage, forKey key: String) {
        memoryCache[key] = image
        
        let filePath = diskCacheURL.appendingPathComponent(key)
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: filePath)
        }
    }
}

