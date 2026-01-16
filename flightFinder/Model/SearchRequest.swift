//
//  SearchRequest.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 11.01.2026.
//

import Foundation

struct SearchRequest: Codable {
    let originQuery: String
    let originFull: String
    let destQuery: String
    let destFull: String
    let date: String?
}
