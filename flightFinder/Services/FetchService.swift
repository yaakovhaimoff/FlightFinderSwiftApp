//
//  Service.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import Foundation

struct FetchService {
    enum FetchError: Error {
        case badResponse(statusCode: Int)
        case networkError
        case decodingError
    }

//    let baseURL: URL = URL(string: "https://unimprovised-brycen-steamily.ngrok-free.dev/api")!
    let baseURL: URL = URL(string: "http://localhost:8080/api")!

    func login(for user: User) async throws -> AuthResponse {
        try await authenticate(user: user, endpoint: "login")
    }

    func register(for user: User) async throws -> AuthResponse {
        try await authenticate(user: user, endpoint: "register")
    }

    private func authenticate(user: User, endpoint: String) async throws -> AuthResponse {
        let url = self.baseURL.appending(path: endpoint)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let bodyData = try JSONEncoder().encode(user)
        request.httpBody = bodyData

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw FetchError.networkError
        }

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw FetchError.badResponse(statusCode: statusCode)
        }

        do {
            let authResponse = try JSONDecoder().decode(AuthResponse.self, from: data)
            return authResponse
        } catch {
            throw FetchError.decodingError
        }
    }

    func searchNextDays(request: SearchRequest) async throws -> FlightSearchResponse {
        try await searchFlights(request: request, endpoint: "search-next-days")
    }

    func searchConnections(request: SearchRequest) async throws -> FlightSearchResponse {
        try await searchFlights(request: request, endpoint: "search-connections")
    }

    private func searchFlights(request: SearchRequest, endpoint: String) async throws -> FlightSearchResponse {
        let url = self.baseURL.appending(path: endpoint)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let token = KeychainService.getToken() {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

        let bodyData = try JSONEncoder().encode(request)
        urlRequest.httpBody = bodyData

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: urlRequest)
        } catch {
            throw FetchError.networkError
        }

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            throw FetchError.badResponse(statusCode: statusCode)
        }

        do {
            let searchResponse = try JSONDecoder().decode(FlightSearchResponse.self, from: data)
            return searchResponse
        } catch {
            throw FetchError.decodingError
        }
    }
}
