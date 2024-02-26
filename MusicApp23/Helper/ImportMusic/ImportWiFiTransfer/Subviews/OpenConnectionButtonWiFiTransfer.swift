//
//  OpenConnectionButtonWiFiTransfer.swift
//  MusicApp23
//
//  Created by Dima on 16.02.2024.
//

import SwiftUI


struct OpenConnectionButtonWiFiTransfer: View {
    
    // MARK: - Properties
    @Binding var serverURL: String
    let startServer: () -> Void
    
    // MARK: - Methods
    var body: some View {
        Button {
            startServer()
        } label: {
            HStack {
                Text("Open Connection")
                    .shuffleAndSortFont()
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.accent.opacity(0.2))
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}
