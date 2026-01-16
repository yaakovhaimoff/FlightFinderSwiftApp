//
//  SearchResults.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 13.01.2026.
//

import SwiftUI
import SwiftData

struct SearchResults: View {
    var vm: ViewModel
    var origin: String
    var destination: String
    @Environment(\.modelContext) private var modelContext
    
    private var nextThreeDays: [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return (0..<3).compactMap { offset in
            Calendar.current.date(byAdding: .day, value: offset, to: Date())
        }.map { formatter.string(from: $0) }
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(vm.flights) { flight in
                    FlightRow(flight: flight, vm: vm)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("\(origin) → \(destination)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SearchResults(vm: ViewModel(), origin: "Athens", destination: "London")
    }
}
