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
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failure(error: Error)
    }
    
    var user: User?
    
    private(set) var status: FetchStatus = .notStarted
    
    let fetchService = FetchService()
    
    func login(for email: String, with password: String) async {
        status = .fetching
        do {
            self.user = User(email: email, password: password)
            try await fetchService.login(for: user!)
            status = .success
        } catch {
            print("error: \(error)")
            status = .failure(error: error)
        }
    }
}

