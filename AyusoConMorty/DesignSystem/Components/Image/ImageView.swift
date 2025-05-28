//
//  ImageView.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 6/4/25.
//

import SwiftUI

/// Image container view
///
/// This function is responsible for:
/// - Calls ImageLoader to get the image
/// - Creates an Imageview containing the image
///
struct ImageView<Content: View>: View {
    @Environment(\.imageCache) private var cache
    private let urlString: String
    private let content: (Image?) -> Content

    init(urlString: String, @ViewBuilder content: @escaping (Image?) -> Content) {
        self.urlString = urlString
        self.content = content
    }
    
    var body: some View {
        ImageViewContainer(urlString: urlString, cache: cache, content: content)
    }

    private struct ImageViewContainer: View {
        @StateObject private var loader: ImageLoader
        private let content: (Image?) -> Content

        init(urlString: String, cache: ImageCache, @ViewBuilder content: @escaping (Image?) -> Content) {
            _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString, cache: cache))
            self.content = content
        }

        var body: some View {
            content(loader.image.map { Image(uiImage: $0) })
        }
    }
}
