//
//  RecentSearchesList.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 14.01.2026.
//

import SwiftUI
import SwiftData

struct RecentSearches: View {
    let recentSearches: [RecentSearch]
    @Binding var origin: String
    @Binding var originCode: String
    @Binding var destination: String
    @Binding var destCode: String

    @Environment(\.modelContext) private var modelContext

    private var sortedSearches: [RecentSearch] {
        let favorites = recentSearches.filter { $0.isFavorite }
            .sorted { $0.timestamp > $1.timestamp }
        let nonFavorites = recentSearches.filter { !$0.isFavorite }
            .sorted { $0.timestamp > $1.timestamp }
        return Array((favorites + nonFavorites).prefix(10))
    }

    var body: some View {
        if !recentSearches.isEmpty {
            VStack(alignment: .leading) {
                Text("Recent Searches")
                    .font(.title3.bold())
                    .padding(.horizontal)
                
                Divider()

                List {
                    ForEach(sortedSearches) { search in
                        VStack {
                            RecentSearchRow(search: search) {
                                origin = search.originFull
                                originCode = search.originCode
                                destination = search.destFull
                                destCode = search.destCode
                            }
                            Divider()
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                toggleFavorite(search)
                            } label: {
                                Image(systemName: search.isFavorite ? "star.slash" : "star.fill")
                            }
                            .tint(.app)
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                deleteSearch(search)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
            }
        }
    }

    private func toggleFavorite(_ search: RecentSearch) {
        search.isFavorite.toggle()
    }

    private func deleteSearch(_ search: RecentSearch) {
        modelContext.delete(search)
    }
}

#Preview {
    RecentSearches(
        recentSearches: [],
        origin: .constant(""),
        originCode: .constant(""),
        destination: .constant(""),
        destCode: .constant("")
    )
}
