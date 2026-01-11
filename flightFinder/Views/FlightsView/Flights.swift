//
//  Search.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 2.01.2026.
//

import SwiftUI

struct Flights: View {
    var onLogout: (() -> Void)?

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Image(.logoPhotoroom)
                        .resizable()
                        .scaledToFit()

                    Spacer()

                    if let onLogout = onLogout {
                        Button {
                            onLogout()
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.title2)
                                .foregroundColor(.app)
                        }
                        .padding(.trailing)
                    }
                }

                TabView {
                    Tab("Search For Flights", systemImage: "airplane") {
                        SearchFlights()
                        Spacer()
                    }
                    Tab("Favorites", systemImage: "star.fill") {
                        FavoriteFlights()
                    }
                }
                .tabViewStyle(.sidebarAdaptable)
                .clipShape(.rect(cornerRadius: 12))
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
        }
    }
}

#Preview {
    Flights()
}
