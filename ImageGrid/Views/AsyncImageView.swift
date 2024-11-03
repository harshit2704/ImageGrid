//
//  AsyncImageView.swift
//  ImageGrid
//
//  Created by Harshit Rastogi on 02/11/24.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader: ImageLoader
    
    init(thumbnail: Thumbnail) {
        _loader = StateObject(wrappedValue: ImageLoader(thumbnail: thumbnail))
    }
    
    var body: some View {
        Image(uiImage: loader.image ?? UIImage())
            .resizable()
            .scaledToFill()
            .onAppear {
                loader.loadImage()
            }
            .onDisappear {
                loader.cancelLoading()
            }
    }
}
