//
//  ImageView.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 6/4/25.
//

import SwiftUI
import UIKit

/// Image container view
///
/// This function is responsible for:
/// - Calls ImageLoader to get the image
/// - Creates an Imageview containing the image
///
struct ImageView<Content: View>: View {
    private let content: (Image?) -> Content
    @StateObject private var loader: ImageLoader
    
    init(urlString: String, @ViewBuilder content: @escaping (Image?) -> Content) {
        _loader = StateObject(wrappedValue: ImageLoader(urlString: urlString))
        self.content = content
    }
    
    var body: some View {
        // Wrap the UiImage in an Image for use in SwiftUI
        content(loader.image.map { Image(uiImage: $0) })
    }
}
