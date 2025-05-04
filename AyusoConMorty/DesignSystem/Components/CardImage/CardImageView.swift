//
//  CardImageView.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

struct CardImageView: View {
    let model: CardImageModel
    
    private let cardHeight: CGFloat = 220
    private let imageRatio: CGFloat = 0.70
    
    var body: some View {
        VStack(spacing: 0) {
            ImageView(urlString: model.image) { image in
                if let image = image {
                    image
                        .resizable()
                        .scaledToFill()
                } else {
                        Color.gray
                }
            }
            .scaledToFill()
            .frame(height: cardHeight * imageRatio)
            .clipped()
            
            VStack(alignment: .leading, spacing: Spacing.s50) {
                Text(model.title)
                    .font(.title3)
                    .fontWeight(.semibold)

                HStack(spacing: Spacing.s75) {
                    Circle()
                        .fill(model.colorBullet)
                        .frame(width: 10, height: 10)
                    
                    Text(model.subTitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, Spacing.s125)
            .padding(.vertical, Spacing.s100)
            .frame(height: cardHeight * (1 - imageRatio))
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
        }
        .frame(height: cardHeight)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
