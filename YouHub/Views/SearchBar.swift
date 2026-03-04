//
//  SearchBar.swift
//  YouHub
//
//  Created by Novak Velimirovic on 2.3.26..
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Searching...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .onSubmit(onSearch)

            Button(action: { onSearch() }) {
                Image(systemName: "magnifyingglass.circle.fill")
                    .font(.title2)
            }
            .buttonStyle(.plain)
        }
    }
}
