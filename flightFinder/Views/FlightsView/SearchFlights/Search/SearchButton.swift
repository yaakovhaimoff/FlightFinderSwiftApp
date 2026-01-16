//
//  SearchButton.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import SwiftUI
import SwiftData

struct SearchButton: View {
    var vm: ViewModel
    var originCode: String
    var origin: String
    var destCode: String
    var destination: String
    @Binding var navigateToResults: Bool
    var recentSearches: [RecentSearch]

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Button {
            performSearch()
        } label: {
            HStack {
                Text("Search")
                    .padding(.leading, 5)
                Spacer()
            }
        }
        .font(.title3)
        .foregroundStyle(.white)
        .padding(5)
        .frame(width: 320)
        .background(.app)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 5)
        .padding(.top, 10)
    }
    
    private func performSearch() {
        guard !originCode.isEmpty, !destCode.isEmpty else { return }
        
        saveRecentSearch()
        
        Task {
            await vm.searchNextDays(
                originCode: originCode,
                originFull: origin,
                destCode: destCode,
                destFull: destination
            )
            navigateToResults = true
        }
    }
    
    private func saveRecentSearch() {
        if let existingSearch = recentSearches.first(where: {
            $0.originCode == originCode && $0.destCode == destCode
        }) {
            existingSearch.timestamp = Date()
            return
        }

        let recentSearch = RecentSearch(
            originCode: originCode,
            originFull: origin,
            destCode: destCode,
            destFull: destination
        )
        modelContext.insert(recentSearch)
    }
}

#Preview {
    SearchButton(
        vm: ViewModel(),
        originCode: "",
        origin: "",
        destCode: "",
        destination: "",
        navigateToResults: .constant(false),
        recentSearches: []
    )
}
