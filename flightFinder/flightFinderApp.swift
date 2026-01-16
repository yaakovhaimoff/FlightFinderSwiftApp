//
//  flightFinderApp.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 2.01.2026.
//

import SwiftUI
import SwiftData

@main
struct flightFinderApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            RecentSearch.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
