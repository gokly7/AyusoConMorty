//
//  TextfieldSearch.swift
//  Ayuso&Morty
//
//  Created by Alberto Ayuso Boza on 3/4/25.
//

import SwiftUI

struct TextfieldSearch: View {
    @Binding var searchText: String
    @State var hintText: String = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(hintText, text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 2)
        )
    }
}
