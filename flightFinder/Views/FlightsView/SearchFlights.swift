//
//  DirectFlight.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import SwiftUI

struct SearchFlights: View {
    let originName: String = "From"
    let destiantionName: String = "To"
    @State private var origin: String = ""
    @State private var destination: String = ""
    @State private var date: Date = Date()
    @FocusState private var originIsFocused: Bool
    @FocusState private var destinationIsFocused: Bool
    
    var body: some View {
        VStack(alignment: .trailing) {
            GroupBox {
                ZStack(alignment: .top) {
                    VStack {
                        HStack(spacing: 20) {
                            SearchField(searchFieldName: originName, searchField: $origin, searchFieldIsFocused: $originIsFocused)

                            SearchField(searchFieldName: destiantionName, searchField: $destination, searchFieldIsFocused: $destinationIsFocused, alignRight: true)
                        }
                        .zIndex(1)

                        SearchButton()
                    }
                }

            } label: {
                Text("Look for your next adventure")
                    .font(.title3.bold())
                    .padding(.leading, 15)
            }
            .padding()
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
        .onTapGesture {
            originIsFocused = false
            destinationIsFocused = false
        }
    }
}

#Preview {
    SearchFlights()
}
