//
//  AyusoConMortyApp.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 4/4/25.
//

import SwiftUI

@main
struct Ayuso_MortyApp: App {    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .preferredColorScheme(.light)
        }
    }
}
