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
    private(set) var loginStatus: FetchStatus = .notStarted
    public var isAuthenticated = false
    var currentEmail: String?

    public var showAlert = false
    var alertTitle = ""
    var alertMessage = ""

    // MARK: - Search State
    var flights: [Flight] = []
    private(set) var searchStatus: FetchStatus = .notStarted
    var currentSearchRequest: SearchRequest?

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
            loginStatus = .success
        }
    }

    // MARK: - Authentication

    func login(for email: String, with password: String) async {
        guard validateInput(email: email, password: password) else { return }

        loginStatus = .fetching
        do {
            let user = User(email: email, password: password)
            let authResponse = try await fetchService.login(for: user)
            try handleAuthSuccess(authResponse: authResponse)
        } catch let error as FetchService.FetchError {
            handleAuthError(error, isLogin: true)
        } catch {
            loginStatus = .failure(message: "An unexpected error occurred.")
        }
    }

    func register(for email: String, with password: String) async {
        guard validateInput(email: email, password: password) else { return }

        loginStatus = .fetching
        do {
            let user = User(email: email, password: password)
            let authResponse = try await fetchService.register(for: user)
            try handleAuthSuccess(authResponse: authResponse)
        } catch let error as FetchService.FetchError {
            handleAuthError(error, isLogin: false)
        } catch {
            loginStatus = .failure(message: "An unexpected error occurred.")
        }
    }

    func logout() {
        KeychainService.deleteAll()
        isAuthenticated = false
        currentEmail = nil
        loginStatus = .notStarted
        user = nil
        authMode = .login
    }

    // MARK: - Auth Mode

    func toggleAuthMode() {
        authMode = (authMode == .login) ? .register : .login
        loginStatus = .notStarted
    }

    // MARK: - Flight Search

    func searchNextDays(originCode: String, originFull: String, destCode: String, destFull: String) async {
        let request = SearchRequest(
            originQuery: originCode,
            originFull: originFull,
            destQuery: destCode,
            destFull: destFull,
            date: nil
        )
        currentSearchRequest = request
        searchStatus = .fetching
        flights = []

        do {
            let response = try await fetchService.searchNextDays(request: request)
            flights = response.flights
            searchStatus = .success
        } catch let error as FetchService.FetchError {
            handleSearchError(error)
        } catch {
            searchStatus = .failure(message: "An unexpected error occurred.")
        }
    }

    func searchConnections(forDate date: String) async {
        guard var request = currentSearchRequest else { return }
        request = SearchRequest(
            originQuery: request.originQuery,
            originFull: request.originFull,
            destQuery: request.destQuery,
            destFull: request.destFull,
            date: date
        )
        searchStatus = .fetching

        do {
            let response = try await fetchService.searchConnections(request: request)
            flights = response.flights
            searchStatus = .success
        } catch let error as FetchService.FetchError {
            handleSearchError(error)
        } catch {
            searchStatus = .failure(message: "An unexpected error occurred.")
        }
    }

    func resetSearchStatus() {
        searchStatus = .notStarted
    }

    private func handleSearchError(_ error: FetchService.FetchError) {
        let message: String
        switch error {
        case .badResponse(let statusCode):
            message = "Server error (\(statusCode))"
        case .networkError:
            message = "Network error. Please check your connection."
        case .decodingError:
            message = "Invalid response from server."
        }
        searchStatus = .failure(message: message)
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
        loginStatus = .success
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
        loginStatus = .failure(message: message)
    }

    private func showAlertWith(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

