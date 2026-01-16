//
//  LoginFields.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 3.01.2026.
//

import SwiftUI

struct LoginFields: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var showPassword: Bool
    var emailFieldIsFocused: FocusState<Bool>.Binding
    var passwordFieldIsFocused: FocusState<Bool>.Binding

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.secondary)

                TextField("email address", text: $email)
                    .keyboardType(.emailAddress)
                    .focused(emailFieldIsFocused)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
            }
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
            )
            .shadow(radius: 5)
            .frame(width: 250)
            .onAppear {
                emailFieldIsFocused.wrappedValue = true
            }

            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.secondary)

                if showPassword {
                    TextField("password", text: $password)
                        .focused(passwordFieldIsFocused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                } else {
                    SecureField("password", text: $password)
                        .focused(passwordFieldIsFocused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                }

                Button {
                    showPassword.toggle()
                } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.secondary)
                        .scaledToFit() 
                }
            }
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
            )
            .shadow(radius: 5)
            .frame(width: 250)
        }
        .onAppear {
            emailFieldIsFocused.wrappedValue = false
            passwordFieldIsFocused.wrappedValue = false
        }
    }
}

#Preview {
    @FocusState var emailFocus: Bool
    @FocusState var passwordFocus: Bool
    LoginFields(
        email: .constant(""),
        password: .constant(""),
        showPassword: .constant(false),
        emailFieldIsFocused: $emailFocus,
        passwordFieldIsFocused: $passwordFocus
    )
}
