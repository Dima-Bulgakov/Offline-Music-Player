//
//  CustomPlayerButton.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI


struct CustomPlayerButton: View {
    
    // MARK: - Properties
    var image: String
    var size: CGFloat
    var color: Color
    var action: () -> Void
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: size)
                .font(.title)
                .foregroundColor(color)
        }
    }
}


// MARK: - Preview
#Preview {
    CustomPlayerButton(image: "pause", size: 24, color: Color.white, action: {})
        .preferredColorScheme(.dark)
}
