//
//  ThumbnailAPI.swift
//  ImageGrid
//
//  Created by Harshit Rastogi on 02/11/24.
//

import Foundation

class ThumbnailAPI {
    func fetchThumbnails(completion: @escaping ([Thumbnail]) -> Void) {
        guard let url = URL(string: "https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=200") else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }

            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                let thumbnails = articles.map { $0.thumbnail }
                
                DispatchQueue.main.async {
                    completion(thumbnails)
                }
            } catch {
                print("Error decoding JSON: \(error)")
                completion([])
            }
        }.resume()
    }
}

