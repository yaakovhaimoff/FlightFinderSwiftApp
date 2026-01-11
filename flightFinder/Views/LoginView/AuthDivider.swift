//
//  AuthDivider.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 10.01.2026.
//

import SwiftUI

struct AuthDivider: View {
    let vm: ViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Rectangle()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(height: 1)

                Text("or")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Rectangle()
                    .fill(Color.secondary.opacity(0.3))
                    .frame(height: 1)
            }
            .frame(width: 250)
            .padding(.top, 16)

            Button {
                vm.toggleAuthMode()
            } label: {
                Text(vm.authMode == .login
                     ? "Don't have an account? Register"
                     : "Already have an account? Login")
                    .font(.subheadline)
                    .foregroundColor(.app)
            }
        }
    }
}

#Preview {
    AuthDivider(vm: ViewModel())
}
