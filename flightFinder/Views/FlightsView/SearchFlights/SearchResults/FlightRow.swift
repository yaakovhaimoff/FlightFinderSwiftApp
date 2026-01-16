//
//  FlightRow.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 11.01.2026.
//

import SwiftUI

struct FlightRow: View {
    var flight: Flight?
    var vm: ViewModel
    
    var body: some View {
        if let flight = flight {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(flight.date)
                        .font(.headline)
                    Spacer()
                    Text(flight.price)
                        .font(.headline)
                        .foregroundColor(.app)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(flight.departure)
                            .font(.subheadline)
                        Text("Departure")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "airplane")
                        .foregroundColor(.app)
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text(flight.arrival)
                            .font(.subheadline)
                        Text("Arrival")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.secondary)
                    Text(flight.duration)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 3)
        }
    }
}

#Preview {
    VStack {
        FlightRow(
            flight: Flight(date: "2026-01-11", departure: "08:00", arrival: "12:30", duration: "4h 30m", price: "$250"),
            vm: ViewModel()
        )
    }
    .padding()
}
