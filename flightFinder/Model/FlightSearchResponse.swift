//
//  FlightSearchResponse.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 11.01.2026.
//

import Foundation

struct FlightSearchResponse: Codable {
    let flights: [Flight]
    let origin: String
    let destination: String
    let date: String?
    let no_connections: Bool?
}
