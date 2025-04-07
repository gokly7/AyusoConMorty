//
//  CharacterModel.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

struct CharacterModel: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let image: String
    let status: String
    let species: String
    let gender: String
    let location: CharacterLocationModel
    
    enum CodingKeys: String, CodingKey {
        case id, name, image, status, species, gender, location
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.status = try container.decode(String.self, forKey: .status)
        self.species = try container.decode(String.self, forKey: .species)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.location = try container.decodeIfPresent(CharacterLocationModel.self, forKey: .location) ?? CharacterLocationModel(name: "unknown")
    }
}

struct CharacterLocationModel: Codable, Equatable, Hashable{
    let name: String
}

