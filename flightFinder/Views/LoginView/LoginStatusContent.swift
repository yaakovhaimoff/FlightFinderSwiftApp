//
//  StatusContent.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 11.01.2026.
//

import SwiftUI

struct StatusContent: View {
    var vm: ViewModel
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        switch vm.loginStatus {
        case .notStarted:
            AuthButton(vm: vm, email: $email, password: $password)
        case .fetching:
            ProgressView()
                .padding(.top, 16)
        case .success:
            EmptyView()
        case .failure(let message):
            AuthButton(vm: vm, email: $email, password: $password)
            Text(message)
                .font(.caption)
                .foregroundColor(.red)
                .padding(.top, 8)
        }
    }
}
