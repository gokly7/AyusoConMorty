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
}

struct CharacterLocationModel: Codable, Equatable, Hashable{
    let name: String
}

