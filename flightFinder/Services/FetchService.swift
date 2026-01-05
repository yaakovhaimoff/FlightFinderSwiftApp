//
//  Service.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import Foundation

struct FetchService {
    enum FetchError: Error {
        case badResponse
    }
    
    let baseURL: URL = URL(string: "http://localhost:8080/api")!
    
    func login(for user: User) async throws {
        let loginURL = self.baseURL.appending(path: "login")
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bodyData = try JSONEncoder().encode(user)
        request.httpBody = bodyData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResponse
        }
    }
}
