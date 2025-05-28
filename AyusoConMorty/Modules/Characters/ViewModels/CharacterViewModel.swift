//
//  CharacterViewModel.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

final class CharacterViewModel: ObservableObject {
    @Published var characters: [ACMCharacter] = []
    @Published var isLoading: Bool = false

    private var cacheCharacters: [ACMCharacter] = []
    private var currentPage: Int = 1
    private var totalPages: Int = 1

    private let service: CharacterServiceProtocol

    init(service: CharacterServiceProtocol = CharacterService()) {
        self.service = service
    }

    /// Load characters from the Rick and Morty API.
    ///
    /// It is an asynchronous function that is responsible for:
    /// - Download from the API all the characters contained in the page indicated in the query
    /// - Download the data response into the APIModel array
    /// - Add all the characters from the page to the array characters.
    ///
    func loadPageCharacters() async {
        await MainActor.run {
            guard !isLoading, currentPage <= totalPages else { return }
            isLoading = true
        }

        do {
            let response = try await service.fetchCharacters(page: currentPage)
            await MainActor.run {
                self.characters.append(contentsOf: response.results)
                self.cacheCharacters = self.characters
                self.totalPages = response.info.pages
                self.currentPage += 1
                self.isLoading = false
            }
        } catch {
            print("Error loading characters: \(error)")
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
        let query = text.trimmingCharacters(in: .whitespaces)
        //Back to results of loadPageCharacters() if text is Empty
        if query.isEmpty {
            await MainActor.run { self.characters = self.cacheCharacters }
            return
        }

    var allResults: [ACMCharacter] = []
    var page = 1
        var pages = 1

        repeat {
            do {
                let resp = try await service.searchCharacters(name: query, page: page)
                allResults.append(contentsOf: resp.results)
                pages = resp.info.pages
                page += 1
            } catch {
                break
            }
        } while page <= pages

        //Check if it is the exact name of the character (Ignore capital letters)
        let filtered = allResults.filter {
            $0.name.lowercased() == query.lowercased()
        }

        await MainActor.run {
            self.characters = filtered
        }
    }
}
