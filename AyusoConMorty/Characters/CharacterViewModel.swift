//
//  CharacterViewModel.swift
//  Ayuso&Morty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterModel] = []
    @Published var searchCharacters: String = ""
    
    private var isLoading: Bool = false
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    var cacheTimer: Timer?
    
    ///Load a page of characters through the api
    func loadPageCharacters() async {
        //Check if there is no character loading in progress or if there are more pages left to load.
        await MainActor.run {
            guard !isLoading, currentPage <= totalPages else { return }
            isLoading = true
        }
        
        let urlString = "https://rickandmortyapi.com/api/character?page=\(currentPage)"
        
        guard let url = URL(string: urlString) else {
            await MainActor.run {
                isLoading = false
            }
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(APIModel.self, from: data)
            
            await MainActor.run {
                self.characters.append(contentsOf: response.results)
                self.totalPages = response.info.pages
                self.currentPage += 1
                self.isLoading = false
            }
        } catch {
            print("CharacterViewModel, 'loadPageCharacters()' Error: \(error)")
            await MainActor.run { self.isLoading = false }
        }
    }
    
    /// Start or reset the cache lifetime
    func startCacheTimer() {
        cacheTimer?.invalidate()
        cacheTimer = Timer.scheduledTimer(withTimeInterval: 420, repeats: false) { [weak self] _ in
            Task { @MainActor in
                self?.clearCache()
                await self?.loadPageCharacters()
            }
        }
    }
    
    /// Reset values of CharacterViewModel
    private func clearCache() {
        self.characters = []
        self.currentPage = 1
        self.totalPages = 1
    }
    
}

///This model needs to have the variable names with the same names as the JSON keys of the API "rickandmortyapi"
private struct APIModel: Codable {
    let info: Info
    let results: [CharacterModel]
}

///This model needs to have the variable names with the same names as the keys in the key "character"
private struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
