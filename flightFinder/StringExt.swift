//
//  StringExt.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 4.01.2026.
//

import Foundation

extension String {
    var isEmailValid: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
