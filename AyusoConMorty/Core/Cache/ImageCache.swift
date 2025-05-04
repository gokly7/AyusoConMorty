//
//  ImageCache.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 4/5/25.
//

import UIKit

/// The cache and its useful life
///
/// This function is responsible for:
/// - Contains the image cache
/// - It has a function capable of activating a 7 minute timer to destroy the image cache.
///
final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    private var timer: Timer?
    
    private init() {
        registerNotifications()
    }
    
    func get(forKey key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
    
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
    
    func clear() {
        cache.removeAllObjects()
    }
    
    // MARK: - Private
    private func registerNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func appDidEnterBackground() {
        timer = Timer.scheduledTimer(withTimeInterval: 900, repeats: false) { [weak self] _ in
            self?.clear()
        }
    }
    
    @objc private func appWillEnterForeground() {
        timer?.invalidate()
    }
}
