//
//  RecentSearchRow.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 14.01.2026.
//

import SwiftUI

struct RecentSearchRow: View {
    let search: RecentSearch
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                if search.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundColor(.app)
                }

                VStack(alignment: .leading) {
                    Text("\(search.originCode) → \(search.destCode)")
                        .font(.subheadline.bold())
                    Text("\(search.originFull) to \(search.destFull)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 5)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    Text("See SearchFlights preview")
}
