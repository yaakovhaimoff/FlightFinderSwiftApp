//
//  ContentView.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 2.01.2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var vm = ViewModel()
    var body: some View {
        VStack {
            LoginForm(vm: vm)
        }
        .fullScreenCover(isPresented: $vm.isAuthenticated) {
            Flights(vm: vm)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [RecentSearch.self], inMemory: true)
}
