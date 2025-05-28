//
//  ACMCharacter+Testable.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 27/5/25.
//

import Foundation

extension ACMCharacter {
    /// Iinitializer for tests
    init(
        id: Int,
        name: String,
        image: String = "",
        status: CharacterStatus,
        species: String,
        gender: String,
        location: CharacterLocation
    ) {
        self.id = id
        self.name = name
        self.image = image
        self.status = status
        self.species = species
        self.gender = gender
        self.location = location
    }
}

