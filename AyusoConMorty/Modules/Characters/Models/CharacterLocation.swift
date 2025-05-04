//
//  CharacterLocation.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 4/5/25.
//

import SwiftUI

/// This model has the data of the character's location.
///
/// Implements the protocols `Codable`, `Equatable`,  `Hashable`.
/// This model is used to decode character information from the API and integrate with SwiftUI.
///
/// - Properties:
///   - name: Character location
struct CharacterLocation: Codable, Equatable, Hashable{
    let name: String
}
