//
//  CharacterSheet.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 5/4/25.
//

import SwiftUI

struct CharacterSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @State var character: Character
    
    var body: some View {
        NavigationView {
            VStack(spacing: Spacing.s200) {
                ImageView(urlString: character.image) { image in
                    if let image = image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    } else {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 120, height: 120)
                            .shadow(radius: 4)
                    }
                }
                
                Text(character.name)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, Spacing.s250)
                
                
                VStack(alignment: .leading, spacing: Spacing.s150) {
                    Row(text: NSLocalizedString("CharacterSheet_level1", comment: ""), value: character.status.rawValue)
                    Divider()
                    Row(text: NSLocalizedString("CharacterSheet_level2", comment: ""), value: character.species)
                    Divider()
                    Row(text: NSLocalizedString("CharacterSheet_level3", comment: ""), value: character.gender)
                    Divider()
                    Row(text: NSLocalizedString("CharacterSheet_level4", comment: ""), value: character.location.name)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 4)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, Spacing.s250)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

private struct Row: View {
    let text: String
    let value: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.subheadline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
