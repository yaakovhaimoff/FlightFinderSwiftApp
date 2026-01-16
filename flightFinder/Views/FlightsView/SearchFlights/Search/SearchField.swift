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
    @Binding var selectedCode: String
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
        HStack {
            TextField(searchFieldName, text: $searchField)
                .focused(searchFieldIsFocused)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .onChange(of: searchField) { updateSuggestions() }
                .onChange(of: searchFieldIsFocused.wrappedValue) { updateSuggestions() }
                .onAppear {
                    searchFieldIsFocused.wrappedValue = false
                }
            
            Button {
                searchField = ""
            } label: {
                Image(systemName: "xmark")
                    .scaledToFit()
            }
            .foregroundStyle(.secondary)
        }
        .padding(5)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
        )
        .shadow(radius: 5)
        .frame(width: 137)
        .overlay(alignment: alignRight ? .topTrailing : .topLeading) {
            if showSuggestions {
                List(searchFieldSuggestions, id: \.self) { airport in
                    Text(airport)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showSuggestions = false
                            searchField = airport
                            selectedCode = airport.airportCodeInParens ?? ""
                            searchFieldIsFocused.wrappedValue = false
                        }
                }
                .listStyle(.plain)
                .glassEffect(in: .rect(cornerRadius: 10))
                .frame(width: 320, height: 250)
                .shadow(radius: 5)
                .offset(x: alignRight ?  3: -3, y: 43)
            }
        }
    }
}

#Preview {
    @FocusState var searchFieldIsFocused: Bool
    SearchField(searchFieldName: "origin", searchField: .constant(""), selectedCode: .constant(""), searchFieldIsFocused: $searchFieldIsFocused)
        .padding()
}
