//
//  LaunchScreenView.swift
//  AYCF
//
//  Created by Yaakov Haimoff on 16.01.2026.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false
    @State var animateViewIn: Bool = false
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.white, .app]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                
                VStack {
                    if animateViewIn {
                        Image(.logo)
                            .resizable()
                            .scaledToFit()
                            .transition(.opacity)
                        
                        Text("Loading...")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
                .animation(.linear(duration: 2).delay(0.5), value: animateViewIn)
            }
            .onAppear {
                animateViewIn = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchScreenView()
}
