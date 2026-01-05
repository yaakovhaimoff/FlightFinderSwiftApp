//
//  LoginForm.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 2.01.2026.
//

import SwiftUI

struct LoginForm: View {
    let vm = ViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var loginSuccessful = true
    @FocusState private var emailFieldIsFocused: Bool
    @FocusState private var passwordFieldIsFocused: Bool
    
    var body: some View {
        ZStack {
            Color.app
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                GroupBox {
                    VStack(spacing: 10) {
                    LoginFields(email: $email, password: $password, alertTitle: $alertTitle, alertMessage: $alertMessage, showAlert: $showAlert, emailFieldIsFocused: $emailFieldIsFocused, passwordFieldIsFocused: $passwordFieldIsFocused)
                    
                        VStack {
                            switch vm.status {
                            case .notStarted:
                                LoginButton(vm: vm, email: $email, password: $password, loginSuccessful: $loginSuccessful, alertTitle: $alertTitle, alertMessage: $alertMessage, showAlert: $showAlert)
                            case .fetching:
                                ProgressView()
                                    .padding(.top, 16)
                            case .success:
                                EmptyView()
                                    .onAppear {
                                        loginSuccessful = true
                                    }
                            case .failure:
                                LoginButton(vm: vm, email: $email, password: $password, loginSuccessful: $loginSuccessful, alertTitle: $alertTitle, alertMessage: $alertMessage, showAlert: $showAlert)
                                Text("Invalid email address or password")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.top, 8)
                            }
                        }
                    }
                } label: {
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(width: 340, height: 250)
                        .padding(.horizontal, -26)
                        .padding(.top, 10)
                }
            }
            .padding()
            .frame(width: 350)
            .fullScreenCover(isPresented: $loginSuccessful) {
                SearchForm()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle),
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
        .onTapGesture {
            emailFieldIsFocused = false
            passwordFieldIsFocused = false
        }
    }
}

#Preview {
    LoginForm()
}
