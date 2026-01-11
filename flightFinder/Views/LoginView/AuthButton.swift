//
//  AuthButton.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 10.01.2026.
//

import SwiftUI

struct AuthButton: View {
    let vm: ViewModel
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        Button {
            Task {
                switch vm.authMode {
                case .login:
                    await vm.login(for: email, with: password)
                case .register:
                    await vm.register(for: email, with: password)
                }
            }
        } label: {
            Text(vm.authMode == .login ? "Login" : "Register")
                .font(.title3.bold())
                .foregroundStyle(.white)
                .padding(5)
                .frame(width: 250)
                .background(.app)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 7)
                .padding(.top, 10)
        }
    }
}

#Preview {
    AuthButton(vm: ViewModel(), email: .constant(""), password: .constant(""))
}
