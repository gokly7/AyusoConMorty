//
//  CharacterViewModelTest.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 27/5/25.
//

import Testing

struct CharacterViewModelTests {

    @Test
    func testLoadPageCharactersWithMock() async throws {
        // 1) Preparo datos de prueba
        let sample = ACMCharacter(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", gender: "Male", location: CharacterLocation(name: "Earth") )
        
        let mockService = MockCharacterService(mockCharacters: [sample])

        // 2) Inyecto el mock en el ViewModel
        let vm = CharacterViewModel(service: mockService)

        // 3) Llamo a la función bajo test
        await vm.loadPageCharacters()

        // 4) Compruebo resultado
        #expect(vm.characters.count == 1)
        #expect(vm.characters.first?.name == "Rick Sanchez")
        #expect(!vm.isLoading)
    }

    @Test
    func testSearchCharacterWithMock() async throws {
        let m1 = ACMCharacter(id: 2, name: "Morty Smith", status: .alive, species: "Human", gender: "Male", location: CharacterLocation(name: "Earth") )
        
        let mockService = MockCharacterService(mockCharacters: [m1])
        let vm = CharacterViewModel(service: mockService)

        await vm.searchCharacter(text: "Morty Smith")

        #expect(vm.characters.count == 1)
        #expect(vm.characters.first?.name == "Morty Smith")
    }
}
