//
//  MockCharacterService.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 27/5/25.
//

import Foundation

/// Mock que permite inyectar personajes “fantasma” para test
struct MockCharacterService: CharacterServiceProtocol {
    /// Lista que el mock devolverá en fetch y search
    var mockCharacters: [ACMCharacter]

    func fetchCharacters(page: Int) async throws -> APIModel {
        return APIModel(
            info: Info(count: mockCharacters.count,
                       pages: 1,
                       next: nil,
                       prev: nil),
            results: mockCharacters
        )
    }

    func searchCharacters(name: String, page: Int) async throws -> APIModel {
        let filtered = mockCharacters.filter {
            $0.name.lowercased().contains(name.lowercased())
        }
        return APIModel(
            info: Info(count: filtered.count,
                       pages: 1,
                       next: nil,
                       prev: nil),
            results: filtered
        )
    }
}

