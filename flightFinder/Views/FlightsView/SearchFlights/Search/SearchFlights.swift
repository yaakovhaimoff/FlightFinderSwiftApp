//
//  SearchFlights.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import SwiftUI
import SwiftData

struct SearchFlights: View {
    var vm: ViewModel
    let originName: String = "From"
    let destinationName: String = "To"
    @State private var origin: String = ""
    @State private var originCode: String = ""
    @State private var destination: String = ""
    @State private var destCode: String = ""
    @State private var navigateToResults: Bool = false
    @FocusState private var originIsFocused: Bool
    @FocusState private var destinationIsFocused: Bool
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RecentSearch.timestamp, order: .reverse) private var recentSearches: [RecentSearch]
    
    var body: some View {
        ZStack {
            VStack(alignment: .trailing) {
                GroupBox {
                    VStack {
                        HStack(spacing: 10) {
                            SearchField(
                                searchFieldName: originName,
                                searchField: $origin,
                                selectedCode: $originCode,
                                searchFieldIsFocused: $originIsFocused
                            )
                            
                            Button {
                                let temp = origin
                                origin = destination
                                destination = temp
                                
                            } label: {
                                Image(systemName: "arrow.left.arrow.right")
                                    .foregroundStyle(.app)
                            }
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 5)
                            
                            SearchField(
                                searchFieldName: destinationName,
                                searchField: $destination,
                                selectedCode: $destCode,
                                searchFieldIsFocused: $destinationIsFocused,
                                alignRight: true
                            )
                        }
                        .zIndex(1)
                        
                        SearchButton(
                            vm: vm,
                            originCode: originCode,
                            origin: origin,
                            destCode: destCode,
                            destination: destination,
                            navigateToResults: $navigateToResults,
                            recentSearches: recentSearches
                        )
                    }
                } label: {
                    Text("Look for your next flights")
                        .font(.title3.bold())
                        .padding(.leading, 15)
                }
                .padding()
                .zIndex(1)
                
                RecentSearches(
                    recentSearches: recentSearches,
                    origin: $origin,
                    originCode: $originCode,
                    destination: $destination,
                    destCode: $destCode
                )
            }
            
            SearchStatusContent(vm: vm)
        }
        .navigationDestination(isPresented: $navigateToResults) {
            SearchResults(vm: vm, origin: origin, destination: destination)
        }
        .ignoresSafeArea()
        .toolbarBackground(.automatic)
        .onTapGesture {
            originIsFocused = false
            destinationIsFocused = false
        }
        .onAppear {
            originIsFocused = false
            destinationIsFocused = false
            vm.resetSearchStatus()
        }
    }
}

#Preview {
    NavigationStack {
        SearchFlights(vm: ViewModel())
    }
}

