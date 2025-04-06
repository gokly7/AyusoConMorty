//
//  CharacterModel.swift
//  Ayuso&Morty
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
}
