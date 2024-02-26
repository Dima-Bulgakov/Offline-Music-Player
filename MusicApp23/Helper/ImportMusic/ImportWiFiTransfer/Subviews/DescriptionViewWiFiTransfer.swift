//
//  DescriptionViewWiFiTransfer.swift
//  MusicApp23
//
//  Created by Dima on 16.02.2024.
//

import SwiftUI


struct DescriptionViewWiFiTransfer: View {
    
    // MARK: - Properties
    @Binding var serverURL: String
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("Type this address into your browser")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.bottom, 5)
            
            /// Display server URL here
            Text(serverURL)
                .foregroundColor(Color.accent)
                .font(.title2)
                .padding(.vertical, 20)
            
            Text("Don't close the page to keep connection opened!")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.white)
                .padding(.top)
        }
    }
}
