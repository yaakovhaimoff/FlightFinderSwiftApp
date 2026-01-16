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
                    VStack {
                        SearchFlights(vm: vm)
                            .padding(.top)
                            .ignoresSafeArea(.keyboard, edges: .bottom)
                        Spacer()
                    }
                    .navigationTitle("Search")
                }
            }
            Tab("Profile", systemImage: "person.fill") {
                NavigationStack {
                    Profile(vm: vm)
                        .navigationTitle("Profile")
                        .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        .clipShape(.rect(cornerRadius: 10))
        .ignoresSafeArea()
    }
}

#Preview {
    Flights(vm: ViewModel())
}
