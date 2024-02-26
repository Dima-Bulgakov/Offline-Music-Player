//
//  HeaderViewWiFiTransfer.swift
//  MusicApp23
//
//  Created by Dima on 16.02.2024.
//

import SwiftUI


struct HeaderViewWiFiTransfer: View {
    
    // MARK: - Properties
    let title: String
    let dismiss: DismissAction
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            
            /// Title
            Text(title)
                .tabBarFont()
                .frame(maxWidth: .infinity)
            
            /// Cancel Button
                .overlay(alignment: .topLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .frame(width: 56)
                            .foregroundColor(Color.accent)
                    }
                    .padding(.top, 6)
                }
                .padding()
        }
    }
}
