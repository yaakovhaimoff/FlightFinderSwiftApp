//
//  Flight.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 11.01.2026.
//

import Foundation

struct Flight: Codable, Identifiable {
    let id = UUID()
    let date: String
    let departure: String
    let arrival: String
    let duration: String
    let price: String

    enum CodingKeys: String, CodingKey {
        case date, departure, arrival, duration, price
    }
}
