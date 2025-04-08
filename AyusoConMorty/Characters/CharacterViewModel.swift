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
    
    /// Load characters from the Rick and Morty API.
    ///
    /// It is an asynchronous function that is responsible for:
    /// - Download from the API all the characters contained in the page indicated in the query
    /// - Download the data response into the APIModel array
    /// - Add all the characters from the page to the array characters.
    ///
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
    
    /// Search for a character from the Rick and Morty API.
    ///
    /// - Parameters:
    ///   - text: Name of the character you want to search for
    ///
    /// It is an asynchronous function that is responsible for:
    /// - Download the characters found from the API by filtering by name. The query does not search for exact name results.
    /// - A loop is made for each page that contains the response from the API.
    /// - Download the response from the API, first check if any character has been found to exit the loop and then download the data into the APIModel array
    /// - Add all the characters from the page to the array allCharactersFound
    /// - Filter if there is one in the character array that contains the same name as the name you searched for and then add the characters found in the characters array
    ///
    func searchCharacter(text: String) async {
        //Back to results of loadPageCharacters() if text is Empty
        if text.isEmpty {
            await MainActor.run {
                self.characters = self.cacheCharacters
            }
            return
        }
        let clearLastSpace = text.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        let encodedQuery = clearLastSpace.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
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
        let filterCharacters = allCharactersFound.filter { $0.name.lowercased() == clearLastSpace.lowercased() }
        
        await MainActor.run {
            self.characters = filterCharacters
        }
    }
}

/// This model needs to have the variable names with the same names as the JSON keys of the API "rickandmortyapi"
private struct APIModel: Codable {
    let info: Info
    let results: [CharacterModel]
}

/// This model needs to have the variable names with the same names as the keys in the key "character"
private struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

/// This model contains the values ​​that the request can return when an error occurs.
private struct ErrorResponse: Codable {
    let error: String
}
