//
//  CharacterService.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 27/5/25.
//

import Foundation

/// Implementation that uses URLSession to connect to the Rick & Morty API
struct CharacterService: CharacterServiceProtocol {
    private let baseURL = "https://rickandmortyapi.com/api/character"

    func fetchCharacters(page: Int) async throws -> APIModel {
        let urlString = "\(baseURL)?page=\(page)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(APIModel.self, from: data)
    }

    func searchCharacters(name: String, page: Int) async throws -> APIModel {
        let encoded = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? name
        let urlString = "\(baseURL)?name=\(encoded)&page=\(page)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)

        // If the API responds “There is nothing here” we return an empty array
        if let errorResp = try? JSONDecoder().decode(ErrorResponse.self, from: data),
           errorResp.error == "There is nothing here" {
            return APIModel(
              info: Info(count: 0, pages: 0, next: nil, prev: nil),
              results: []
            )
        }

        return try JSONDecoder().decode(APIModel.self, from: data)
    }
}
