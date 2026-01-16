//
//  SearchStatusContent.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 15.01.2026.
//

import SwiftUI

struct SearchStatusContent: View {
    var vm: ViewModel
    
    var body: some View {
        switch vm.searchStatus {
        case .notStarted, .success:
            EmptyView()
        case .fetching:
            VStack {
                ProgressView()
                Text("Searching...")
                    .font(.headline)
                Text("This may take a while...")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
        case .failure(let message):
            VStack {
                Text(message)
                    .foregroundColor(.red)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    SearchStatusContent(vm: ViewModel())
}
