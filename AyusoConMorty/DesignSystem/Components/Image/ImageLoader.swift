//
//  ImageLoader.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 4/5/25.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let urlString: String
    var cancellable: AnyCancellable?

    let cache: ImageCache

    init(urlString: String, cache: ImageCache) {
        self.urlString = urlString
        self.cache = cache
        loadImage()
    }

    private func loadImage() {
        guard let url = URL(string: urlString) else { return }

        // Check if image exists in cache
        if let cachedImage = cache.get(forKey: urlString) {
            self.image = cachedImage
            return
        }

        // Download image from URL
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let self = self, let downloadedImage = downloadedImage else { return }
                self.cache.set(downloadedImage, forKey: self.urlString)
                self.image = downloadedImage
            }
    }

    deinit {
        cancellable?.cancel()
    }
}
