//
//  ContentView.swift
//  ImageGrid
//
//  Created by Harshit Rastogi on 02/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var thumbnails: [Thumbnail] = []
    private let api = ThumbnailAPI()

    var body: some View {
        NavigationView {
            if thumbnails.isEmpty {
                ProgressView("Loading...")
                    .onAppear(perform: fetchThumbnails)
            } else {
                ImageGridView(thumbnails: thumbnails)
                    .navigationTitle("Image Grid")
            }
        }
    }

    private func fetchThumbnails() {
        api.fetchThumbnails { fetchedThumbnails in
            self.thumbnails = Array(fetchedThumbnails.prefix(200))
        }
    }
}

#Preview {
    ContentView()
}
