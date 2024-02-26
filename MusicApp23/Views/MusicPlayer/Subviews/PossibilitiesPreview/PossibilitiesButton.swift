//
//  PossibilitiesButton.swift
//  MusicApp23
//
//  Created by Dima on 26.02.2024.
//

import SwiftUI

struct PossibilitiesButton: View {
    
    // MARK: - Properties
    let image: String
    let title: String
    var showsSpacer: Bool = true
    let action: () -> ()
    
    // MARK: - Body
    var body: some View {
        
        Button {
            action()
        } label: {
            HStack(spacing: 15) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 22)
                    .foregroundColor(Color.accent)
                Text(title)
                    .foregroundColor(.white)
                    .artistFont()
                if showsSpacer {
                    Spacer()
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, showsSpacer ? 0 : 8)
            .padding(14)
            .frame(maxWidth: .infinity)
            .background(Color.accent.opacity(0.2))
            .cornerRadius(10)
            .frame(height: 52)
        }
    }
}
