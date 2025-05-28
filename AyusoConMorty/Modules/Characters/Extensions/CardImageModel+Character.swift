//
//  CardImageModel+Character.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 4/5/25.
//

import SwiftUI

extension CardImageModel {
    init(character: ACMCharacter) {
        self.init(
            image: character.image,
            title: character.name,
            subTitle: "\(character.status) - \(character.species)",
            colorBullet: character.status.color
        )
    }
}
