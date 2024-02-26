//
//  SortMenuButton.swift
//  MusicApp23
//
//  Created by Dima on 05.02.2024.
//

import SwiftUI


struct CustomeMenuButton: View {
    
    // MARK: - Properties
    let image: String
    let text: String
    let action: () -> ()
    
    // MARK: - Body
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18)
                    .padding(.trailing, 8)
                    .padding(.vertical, 5)
                    .foregroundColor(Color.accent)
                Text(text)
                    .songMenuFont()
            }
            .padding(.horizontal, 14)
        }
    }
}

// MARK: - Preview
#Preview {
    CustomeMenuButton(image: "artist", text: "Artist (A-z)", action: {})
}
