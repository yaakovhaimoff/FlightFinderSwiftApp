//
//  Profile.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import SwiftUI

struct Profile: View {
    var vm: ViewModel

    var body: some View {
        List {
            // MARK: - Header Section
            Section {
                HStack(spacing: 16) {
                    Circle()
                        .fill(.app.opacity(0.2))
                        .frame(width: 70, height: 70)
                        .overlay {
                            Text(vm.currentEmail?.prefix(1).uppercased() ?? "?")
                                .font(.largeTitle.bold())
                                .foregroundColor(.app)
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(vm.currentEmail ?? "No email")
                            .font(.headline)
                        Text("Flight Finder Member")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }

            // MARK: - Preferences Section
            Section("Preferences") {
                SettingsRow(icon: "airplane.circle", title: "Home Airport", value: "Not set")
                SettingsRow(icon: "eurosign.circle", title: "Currency", value: "EUR")
                SettingsRow(icon: "moon.circle", title: "Appearance", value: "System")
            }

            // MARK: - About Section
            Section("About") {
                SettingsRow(icon: "info.circle", title: "About App", value: nil)
                SettingsRow(icon: "star.circle", title: "Rate App", value: nil)
            }

            // MARK: - Logout Section
            Section {
                Button(role: .destructive) {
                    vm.logout()
                } label: {
                    HStack {
                        Spacer()
                        Label("Log Out", systemImage: "rectangle.portrait.and.arrow.right")
                            .font(.headline)
                        Spacer()
                    }
                }
            }
        }
    }
}

// MARK: - Settings Row Component

struct SettingsRow: View {
    let icon: String
    let title: String
    let value: String?

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.app)
                .font(.title2)
                .frame(width: 30)

            Text(title)

            Spacer()

            if let value {
                Text(value)
                    .foregroundColor(.secondary)
            }

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
        }
    }
}

#Preview {
    NavigationStack {
        Profile(vm: ViewModel())
            .navigationTitle("Profile")
    }
}
