//
//  RecentSearch.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 11.01.2026.
//

import Foundation
import SwiftData

@Model
final class RecentSearch {
    var originCode: String
    var originFull: String
    var destCode: String
    var destFull: String
    var timestamp: Date
    var isFavorite: Bool = false

    init(originCode: String, originFull: String, destCode: String, destFull: String) {
        self.originCode = originCode
        self.originFull = originFull
        self.destCode = destCode
        self.destFull = destFull
        self.timestamp = Date()
    }
}
