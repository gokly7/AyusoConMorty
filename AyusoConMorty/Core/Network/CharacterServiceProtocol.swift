//
//  CharacterServiceProtocol.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 27/5/25.
//

import Foundation

/// Define la interfaz para cargar personajes
protocol CharacterServiceProtocol {
    /// Carga la página indicada
    func fetchCharacters(page: Int) async throws -> APIModel

    /// Busca personajes por nombre (paginado igual que fetch)
    func searchCharacters(name: String, page: Int) async throws -> APIModel
}
