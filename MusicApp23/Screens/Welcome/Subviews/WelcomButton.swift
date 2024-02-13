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
        
        /// Shape
        GeometryReader { proxy in
            let size = proxy.size
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.accent, lineWidth: 1)
                .overlay(
                    VStack {
                        
                        /// Image
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: size.height * 0.35)
                        
                        /// Title
                        Text(title)
                            .font(.system(size: size.height * 0.17))
                            .foregroundColor(Color.primaryFont)
                            .padding(.top, 5)
                    }
                )
                .frame(height: size.height * 1)
                .onTapGesture {
                    action()
            }
                
        }
    }
}

#Preview {
    WelcomButton(image: "filesW", title: "Files") {}
        .preferredColorScheme(.dark)
}
