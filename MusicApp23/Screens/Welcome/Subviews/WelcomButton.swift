//
//  WelcomButton.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct WelcomButton: View {
    
    // MARK: - Properties
    let image: String
    let title: String
    let action: () -> ()
    
    // MARK: - Body
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .stroke(Color.accent, lineWidth: 1)
            .frame(height: 88)
            .overlay(
                VStack {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32)
                    Text(title)
                        .tabBarFont()
                }
            )
            .onTapGesture {
                action()
            }
    }
}

//#Preview {
//    WelcomButton(image: "filesW", title: "Files")
//}
