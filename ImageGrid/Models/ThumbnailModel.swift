//
//  ThumbnailModel.swift
//  ImageGrid
//
//  Created by Harshit Rastogi on 02/11/24.
//

import Foundation

struct Article: Codable {
    let id: String
    let title: String
    let language: String
    let thumbnail: Thumbnail
    let mediaType: Int
    let coverageURL: String
    let publishedAt: String
    let publishedBy: String
    let description: String
}

struct Thumbnail: Codable, Identifiable {
    let id: String
    let version: Int
    let domain: String
    let basePath: String
    let key: String
    let qualities: [Int]
    let aspectRatio: Double

    var imageURL: URL? {
        return URL(string: "\(domain)/\(basePath)/0/\(key)")
    }
}

