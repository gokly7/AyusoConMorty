//
//  ImageCache+Environment.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 5/5/25.
//

import SwiftUI

private struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = ImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
