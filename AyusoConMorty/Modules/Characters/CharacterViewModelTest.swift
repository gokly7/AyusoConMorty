//
//  CharacterViewModelTest.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 7/4/25.
//

//TODO: Ver que hacer con esto

//TEST
#if DEBUG
extension CharacterViewModel {
    var isLoadingTest: Bool {
        return self.isLoading
    }
    var cacheCharactersTest: [Character] {
        return self.cacheCharacters
    }
}
#endif
