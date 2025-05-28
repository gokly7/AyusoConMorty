//
//  CharacterAPIModels.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 27/5/25.
//

import Foundation

/// This model needs to have the variable names with the same names as the JSON keys of the API "rickandmortyapi"
struct APIModel: Codable {
    let info: Info
    let results: [ACMCharacter]
}

/// This model needs to have the variable names with the same names as the keys in the key "ACMCharacter"
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

/// This model contains the values ​​that the request can return when an error occurs.
struct ErrorResponse: Codable {
    let error: String
}
