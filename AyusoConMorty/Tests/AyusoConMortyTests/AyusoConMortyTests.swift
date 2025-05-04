//
//  AyusoConMortyTests.swift
//  AyusoConMortyTests
//
//  Created by Alberto Ayuso Boza on 4/4/25.
//

import Testing
@testable import AyusoConMorty

struct AyusoConMortyTests {
    
    /// Default Search Characters
    ///
    /// This test verifies that when performing the main character search,
    /// if this is true the character array should not be empty.
    ///
    @Test
    func testLoadCharacters() async throws {

        let characterViewModel = CharacterViewModel()
        await characterViewModel.loadPageCharacters()
        
        #expect(!characterViewModel.characters.isEmpty)
        #expect(!characterViewModel.isLoadingTest)
        #expect(!characterViewModel.cacheCharactersTest.isEmpty)
    }
    
    /// Specific Search Characters
    ///
    /// This test checks that the searchCharacter function
    /// is able to return the users and update the character array.
    ///
    @Test
    func testSearchCharacter() async throws {

        let characterViewModel = CharacterViewModel()
        await characterViewModel.searchCharacter(text: "Morty Smith")
        
        #expect(!characterViewModel.characters.isEmpty)
    }
    
    /// Character Search Not Found
    ///
    /// This test checks if the searchCharacter function
    /// does not find the user completely empty the array
    ///
    @Test
    func testEmptySearchCharacter() async throws {

        let characterViewModel = CharacterViewModel()
        await characterViewModel.searchCharacter(text: "Morty")
        
        #expect(characterViewModel.characters.isEmpty)
    }
}
