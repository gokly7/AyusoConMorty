//
//  CharacterStatus.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 4/5/25.
//

import SwiftUI

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var color: Color {
        switch self {
            case .alive: return .green
            case .dead: return .red
            case .unknown: return .gray
        }
    }
}
