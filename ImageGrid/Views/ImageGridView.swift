//
//  ImageGridView.swift
//  ImageGrid
//
//  Created by Harshit Rastogi on 02/11/24.
//

import SwiftUI

struct ImageGridView: View {
    let thumbnails: [Thumbnail]
    private let cellSize = UIScreen.main.bounds.width / 3
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0) {
                ForEach(thumbnails, id: \.id) { thumbnail in
                    AsyncImageView(thumbnail: thumbnail)
                        .aspectRatio(1, contentMode: .fill)
                        .frame(width: cellSize, height: cellSize)
                        .clipped()
                }
            }
            .padding()
        }
    }
}
