//
//  CharacterViewModel.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

class CharacterViewModel: ObservableObject {
    @Published var characters: [CharacterModel] = []
    
    internal var cacheCharacters: [CharacterModel] = []
    internal var isLoading: Bool = false
    private var currentPage: Int = 1
    private var totalPages: Int = 1
    
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
                self.cacheCharacters = self.characters
                self.totalPages = response.info.pages
                self.currentPage += 1
                self.isLoading = false
            }
        } catch {
            print("CharacterViewModel, 'loadPageCharacters()' Error: \(error)")
            await MainActor.run { self.isLoading = false }
        }
    }
    
    /// Search for characters by exact name
    ///
    /// - Parameters:
    ///   - text: Name of the character you want to search for
    func searchCharacter(text: String) async {
        //Back to results of loadPageCharacters
        if text.isEmpty {
            await MainActor.run {
                self.characters = self.cacheCharacters
            }
            return
        }
        
        let encodedQuery = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        var page = 1
        var totalPages = 1
        var allCharactersFound: [CharacterModel] = []
        
        repeat {
            let urlString = "https://rickandmortyapi.com/api/character/?name=\(encodedQuery)&page=\(page)"
            guard let url = URL(string: urlString) else {
                break
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
    
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data),
                       errorResponse.error == "There is nothing here" {
                        break
                    }
                
                let response = try JSONDecoder().decode(APIModel.self, from: data)
                allCharactersFound.append(contentsOf: response.results)
                totalPages = response.info.pages
                page += 1
            } catch {
                print("CharacterViewModel, 'searchCharacter()' Error: \(error)")
                break
            }
        } while page <= totalPages
        
        //Check if it is the exact name of the character (Ignore capital letters)
        let filterCharacters = allCharactersFound.filter { $0.name.lowercased() == text.lowercased() }
        
        await MainActor.run {
            self.characters = filterCharacters
        }
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

private struct ErrorResponse: Codable {
    let error: String
}
