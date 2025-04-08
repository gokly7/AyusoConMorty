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

/// The cache and its useful life
///
/// This function is responsible for:
/// - Contains the image cache
/// - It has a function capable of activating a 7 minute timer to destroy the image cache.
///
class ImageCache {
    static let shared: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        return cache
    }()
    
    private static var timer: Timer?
    
    static func registerNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appInBackground),
                                               name: UIApplication.didEnterBackgroundNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(appInForeground),
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
        
    @objc private static func appInBackground() {
        timer = Timer.scheduledTimer(withTimeInterval: 900, repeats: false) { _ in
            //Remove ImageCache
            DispatchQueue.main.async {
                shared.removeAllObjects()
            }
        }
    }
    
    @objc private static func appInForeground() {
        //Stop timer for remove cache
        timer?.invalidate()
        timer = nil
    }
}


private class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
        loadImage()
    }
    
    private func loadImage() {
        let cacheKey = NSString(string: urlString)
        //See if we have this image in cache
        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        // Download image from URL
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("ImageLoader, 'loadImage()' Error: \(error)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else { return }
            //Add the image to the cache
            DispatchQueue.main.async {
                ImageCache.shared.setObject(image, forKey: cacheKey)
                self.image = image
            }
        }.resume()
    }
}
