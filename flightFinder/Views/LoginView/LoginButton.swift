//
//  LoginButton.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 3.01.2026.
//

import SwiftUI

struct LoginButton: View {
    let vm: ViewModel
    @Binding var email: String
    @Binding var password: String
    @Binding var loginSuccessful: Bool
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var showAlert: Bool
    
    var body: some View {
        Button {
            login()
        } label: {
            Text("Login")
                .font(.title)
                .foregroundStyle(.white)
                .padding(.horizontal, 92)
                .background(.app)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(radius: 7)
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .padding(.bottom, 40)
        }
    }
    
    func login() {
        //        Validate inputs synchronously first
        guard !email.isEmpty, !password.isEmpty else {
            alertTitle = "Invalid Input"
            alertMessage = "Please fill all fields"
            showAlert = true
            return
        }
        
        Task { @MainActor in
//            await vm.login(for: "hyaakov@aol.com", with: "Yh160716")
            await vm.login(for: email, with: password)
        }
        
    }
}

#Preview {
    LoginButton(vm: ViewModel(), email: .constant(""), password: .constant(""), loginSuccessful: .constant(false), alertTitle: .constant(""), alertMessage: .constant(""), showAlert: .constant(false))
}
