//
//  SearchButton.swift
//  flightFinder
//
//  Created by Yaakov Haimoff on 5.01.2026.
//

import SwiftUI

struct SearchButton: View {
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Text("Search")
                    .padding(.leading, 5)
                Spacer()
            }
        }
        .font(.title3)
        .foregroundStyle(.white)
        .padding(5)
        .frame(width: 320)
        .background(.app)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(radius: 5)
        .padding(.top, 10)
    }
}

#Preview {
    SearchButton()
}
