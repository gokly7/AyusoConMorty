//
//  CardImageModel.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 5/4/25.
//

import SwiftUI

/// A model that represents the visual content for a CardImage.
///
/// - Properties:
///   - image: Representative image
///   - title: Main text
///   - subTitle: Additional description
///   - colorBullet: Color of the ball to the right of the subtitle
struct CardImageModel {
    let image: String
    let title: String
    let subTitle: String
    let colorBullet: Color
}
