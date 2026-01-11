//
//  HomeView.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 11.01.2026.
//

import SwiftUI

struct HomeView: View {
    @State private var vm = ViewModel()
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.app
                    .opacity(0.5)
                    .ignoresSafeArea()
                
                LoginForm(vm: vm)
            }
        }
        .fullScreenCover(isPresented: $vm.isAuthenticated) {
            Flights(onLogout: {
                vm.logout()
            })
        }
    }
}

#Preview {
    HomeView()
}
