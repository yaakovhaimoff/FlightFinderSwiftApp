//
//  SearchFields.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import SwiftUI

struct SearchField: View {
    var searchFieldName: String
    @Binding var searchField: String
    var searchFieldIsFocused: FocusState<Bool>.Binding
    var alignRight: Bool = false
    @State private var showSuggestions: Bool = false
    private let allAirports = Airports().airports

    private var searchFieldSuggestions: [String] {
        guard !searchField.isEmpty else { return allAirports }
        return allAirports.filter { $0.localizedCaseInsensitiveContains(searchField) }
    }

    private func updateSuggestions() {
        showSuggestions = searchFieldIsFocused.wrappedValue && !searchFieldSuggestions.isEmpty
    }

    var body: some View {
        TextField(searchFieldName, text: $searchField)
        .focused(searchFieldIsFocused)
        .textFieldStyle(.roundedBorder)
        .textInputAutocapitalization(.never)
        .disableAutocorrection(true)
        .frame(width: 150)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 5)
        .onChange(of: searchField) { updateSuggestions() }
        .onChange(of: searchFieldIsFocused.wrappedValue) { updateSuggestions() }
        .overlay(alignment: alignRight ? .topTrailing : .topLeading) {
            if showSuggestions {
                List(searchFieldSuggestions, id: \.self) { airport in
                    Text(airport)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showSuggestions = false
                            searchField = airport
                            searchFieldIsFocused.wrappedValue = false
                        }
                }
                .listStyle(.plain)
                .frame(width: 280, height: 250)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 5)
                .offset(y: 50)
            }
        }
    }
}

#Preview {
    @FocusState var searchFieldIsFocused: Bool
    SearchField(searchFieldName: "origin", searchField: .constant(""), searchFieldIsFocused: $searchFieldIsFocused)
        .padding()
}
