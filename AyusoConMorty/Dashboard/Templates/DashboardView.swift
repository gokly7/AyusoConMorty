//
//  DashboardView.swift
//  Ayuso&Morty
//
//  Created by Alberto Ayuso Boza on 2/4/25.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var characterViewModel = CharacterViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var inputSearch: String = ""
    @State private var showingSheet = false
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.s200) {
            
            Text(NSLocalizedString("App_name", comment: ""))
                .font(.custom(Typography.mainBold, size: 34))
                .foregroundColor(.black)
                .padding(.horizontal, Spacing.s200)
            
            TextfieldSearch(searchText: $inputSearch, hintText: NSLocalizedString("TextfieldSearch_placeHolder", comment: ""))
                .padding(.horizontal, Spacing.s200)
                .onSubmit {
                    Task {
                        characterViewModel.searchCharacters = inputSearch
                    }
                }
            
            Text(NSLocalizedString("DashboardView_subTitle", comment: ""))
                .font(.custom(Typography.main, size: 20))
                .foregroundColor(.black)
                .padding(.horizontal, Spacing.s300)
                .padding(.bottom, Spacing.s50)
            
            //This ScrollView is "infinite", but it is fragmented by pages so as not to load all the characters at once when starting the DashboardTemplate.
            ScrollView {
                LazyVGrid(columns: columns, spacing: Spacing.s200) {
                    ForEach(characterViewModel.characters) { character in
                        CardImage(model: CardImageModel(image: character.image, title: character.name, subTitle: "\(character.status) - \(character.species)", colorBullet: statusColor(status: character.status)))
                        //We review each character that appears on the screen to check if it is the last one on the page and to be able to start loading the next page.
                            .onAppear {
                                if character == characterViewModel.characters.last {
                                    Task {
                                        await characterViewModel.loadPageCharacters()
                                    }
                                }
                            }
                            .onTapGesture {
                                    showingSheet = true //TODO: mirar de simplificar esto
                            }
                        //TODO: Crear el CharacterSheet
                            .sheet(isPresented: $showingSheet) {
                                Text("Character Page")
                                    .font(.largeTitle)
                                    .padding()
                            }
                    }
                }
                .padding(.horizontal)
                //This is the first character load, make the request for the characters on the first page
                .task {
                    await characterViewModel.loadPageCharacters()
                }
            }
            Spacer()
        }
        .padding(.top)
        //When the app goes into the background it starts counting the cache lifetime. When it enters the screen the timer stops
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .background {
                characterViewModel.startCacheTimer()
            } else if newPhase == .active {
                characterViewModel.cacheTimer?.invalidate()
            }
        }
    }
}

private func statusColor(status: String) -> Color {
    switch status {
    case "Alive":
        return .green
    case "unknown":
        return .gray
    case "Dead":
        return .red
    default:
        return .black
    }
}
