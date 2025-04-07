//
//  CharacterViewModelTest.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 7/4/25.
//

//TEST
#if DEBUG
extension CharacterViewModel {
    var isLoadingTest: Bool {
        return self.isLoading
    }
    var cacheCharactersTest: [CharacterModel] {
        return self.cacheCharacters
    }
}
#endif
