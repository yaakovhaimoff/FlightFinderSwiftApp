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
    @Binding var alertTitle: String
    @Binding var alertMessage: String
    @Binding var showAlert: Bool
    var emailFieldIsFocused: FocusState<Bool>.Binding
    var passwordFieldIsFocused: FocusState<Bool>.Binding
    
    var body: some View {
        VStack(spacing: 20) {
            TextField(
                "email address",
                text: $email
            )
            .keyboardType(.emailAddress)
            .textFieldStyle(.roundedBorder)
            .focused(emailFieldIsFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 5)
            .frame(width: 250)
//            .padding(.top, 40)
            .onAppear {
                emailFieldIsFocused.wrappedValue = true
            }
            .onSubmit {
                passwordFieldIsFocused.wrappedValue = true
                if !email.isEmailValid {
                    alertTitle = "Invalid Input"
                    alertMessage = "Please enter a valid email address."
                    showAlert = true
                }
            }
            
            SecureField(
                "password",
                text: $password
            )
            .textFieldStyle(.roundedBorder)
            .focused(passwordFieldIsFocused)
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 5)
            .frame(width: 250)
//            .padding(.top, 10)
            .onSubmit {
                if email.isEmpty || password.isEmpty {
                    alertMessage = "Please fill all fields."
                    showAlert = true
                } else if !email.isEmailValid {
                    alertTitle = "Invalid Input"
                    alertMessage = "Please enter a valid email address."
                    showAlert = true
                }
            }
        }
    }
}

#Preview {
    @FocusState var emailFocus: Bool
    @FocusState var passwordFocus: Bool
    LoginFields(email: .constant(""), password: .constant(""), alertTitle: .constant(""), alertMessage: .constant(""), showAlert: .constant(false), emailFieldIsFocused: $emailFocus, passwordFieldIsFocused: $passwordFocus)
}
