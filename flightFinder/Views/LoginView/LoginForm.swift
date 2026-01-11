//
//  LoginForm.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 2.01.2026.
//

import SwiftUI

struct LoginForm: View {
    @Bindable var vm: ViewModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @FocusState private var emailFieldIsFocused: Bool
    @FocusState private var passwordFieldIsFocused: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Image(.logoPhotoroom)
                .resizable()
                .scaledToFit()
                .padding(.bottom,  50)
            
            LoginFields(
                email: $email,
                password: $password,
                showPassword: $showPassword,
                emailFieldIsFocused: $emailFieldIsFocused,
                passwordFieldIsFocused: $passwordFieldIsFocused
            )
            
            StatusContent(vm: vm, email: $email, password: $password)
            
            AuthDivider(vm: vm)
        }
        .padding()
        .frame(width: 350)
        .alert(vm.alertTitle, isPresented: $vm.showAlert) {
            Button("OK") {}
        } message: {
            Text(vm.alertMessage)
        }
        .onChange(of: vm.authMode) {
            email = ""
            password = ""
        }
        .onTapGesture {
            emailFieldIsFocused = false
            passwordFieldIsFocused = false
        }
    }
}

#Preview {
    LoginForm(vm: ViewModel())
}
