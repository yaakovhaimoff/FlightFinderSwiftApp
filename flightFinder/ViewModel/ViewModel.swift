//
//  ViewModel.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 2.01.2026.
//

import Foundation
import SwiftUI
internal import Combine

@Observable
class ViewModel {
    enum FetchStatus: Equatable {
        case notStarted
        case fetching
        case success
        case failure(message: String)
    }

    enum AuthMode {
        case login
        case register
    }

    var user: User?
    var authMode: AuthMode = .login
    private(set) var status: FetchStatus = .notStarted
    public var isAuthenticated = false
    var currentEmail: String?

    public var showAlert = false
    var alertTitle = ""
    var alertMessage = ""

    private let fetchService = FetchService()

    // MARK: - Initialization

    init() {
        checkExistingAuth()
    }

    func checkExistingAuth() {
        if let token = KeychainService.getToken(),
           let email = KeychainService.getEmail(),
           !token.isEmpty {
            currentEmail = email
            isAuthenticated = true
            status = .success
        }
    }

    // MARK: - Authentication

    func login(for email: String, with password: String) async {
        guard validateInput(email: email, password: password) else { return }

        status = .fetching
        do {
            let user = User(email: email, password: password)
            let authResponse = try await fetchService.login(for: user)
            try handleAuthSuccess(authResponse: authResponse)
        } catch let error as FetchService.FetchError {
            handleAuthError(error, isLogin: true)
        } catch {
            status = .failure(message: "An unexpected error occurred.")
        }
    }

    func register(for email: String, with password: String) async {
        guard validateInput(email: email, password: password) else { return }

        status = .fetching
        do {
            let user = User(email: email, password: password)
            let authResponse = try await fetchService.register(for: user)
            try handleAuthSuccess(authResponse: authResponse)
        } catch let error as FetchService.FetchError {
            handleAuthError(error, isLogin: false)
        } catch {
            status = .failure(message: "An unexpected error occurred.")
        }
    }

    func logout() {
        KeychainService.deleteAll()
        isAuthenticated = false
        currentEmail = nil
        status = .notStarted
        user = nil
        authMode = .login
    }

    // MARK: - Auth Mode

    func toggleAuthMode() {
        authMode = (authMode == .login) ? .register : .login
        status = .notStarted
    }

    // MARK: - Private Helpers

    private func validateInput(email: String, password: String) -> Bool {
        guard !email.isEmpty, !password.isEmpty else {
            showAlertWith(title: "Invalid Input", message: "Please fill all fields")
            return false
        }

        guard email.isEmailValid else {
            showAlertWith(title: "Invalid Input", message: "Please enter a valid email address.")
            return false
        }

        return true
    }

    private func handleAuthSuccess(authResponse: AuthResponse) throws {
        try KeychainService.saveToken(authResponse.token)
        try KeychainService.saveEmail(authResponse.email)
        currentEmail = authResponse.email
        isAuthenticated = true
        status = .success
    }

    private func handleAuthError(_ error: FetchService.FetchError, isLogin: Bool) {
        let message: String
        switch error {
        case .badResponse(let statusCode):
            if isLogin {
                message = statusCode == 401 ? "Invalid email or password" : "Server error (\(statusCode))"
            } else {
                message = statusCode == 409 ? "Email already registered" : "Server error (\(statusCode))"
            }
        case .networkError:
            message = "Network error. Please check your connection."
        case .decodingError:
            message = "Invalid response from server."
        }
        status = .failure(message: message)
    }

    private func showAlertWith(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

