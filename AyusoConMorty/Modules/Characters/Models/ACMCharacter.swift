//
//  ACMCharacter.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

/// This model has the characters' data
///
/// Implements the protocols `Codable`, `Identifiable`, `Equatable`, `Hashable`.
/// This model is used to decode character information from the API and integrate with SwiftUI,
/// allowing use in lists and views that require unique identification.
///
/// - Properties:
///   - id: Unique character identifier
///   - name: Character name
///   - image: Character image
///   - status: Character's state of life
///   - species: Character species
///   - gender: Character's gender
///   - location: Character location, use: `CharacterLocationModel`.
struct ACMCharacter: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let image: String
    let status: CharacterStatus
    let species: String
    let gender: String
    let location: CharacterLocation
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, status, species, gender, location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.status = try container.decode(CharacterStatus.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.location = try container.decodeIfPresent(CharacterLocation.self, forKey: .location) ?? CharacterLocation(name: "unknown")
    }
}
