//
//  Flights.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 2.01.2026.
//

import SwiftUI

struct Flights: View {
    var vm: ViewModel

    var body: some View {
        TabView {
            Tab("Search Flights", systemImage: "airplane") {
                NavigationStack {
                    SearchFlights(vm: vm)
                        .padding(.top)
                        .navigationTitle("Search")
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                    Spacer()
                }
            }
            Tab("Profile", systemImage: "person.fill") {
                NavigationStack {
                    Profile()
                        .navigationTitle("Profile")
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
        }
        ignoresSafeArea()
        .tabViewStyle(.sidebarAdaptable)
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    Flights(vm: ViewModel())
}
