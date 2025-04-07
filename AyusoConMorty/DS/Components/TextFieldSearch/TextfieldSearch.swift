//
//  TextfieldSearch.swift
//  AyusoConMorty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

struct TextfieldSearch: View {
    @Binding var searchText: String
    @State var hintText: String = ""
    var buttonRight: (() -> Void)?
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(hintText, text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .accessibilityIdentifier("textfieldSearch")
            if !searchText.isEmpty {
                Button(action: {
                    if let action = buttonRight {
                        action()
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, Spacing.s125)
        .padding(.horizontal, Spacing.s150)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 2)
        )
    }
}
