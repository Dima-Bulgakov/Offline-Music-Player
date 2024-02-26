//
//  CustomShareText.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import SwiftUI


struct CustomShareText: View {
    
    // MARK: - Properties
    let text: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(Color.accent)
            Text(text)
        }
    }
}


// MARK: - Preview
#Preview {
    CustomShareText(text: "text")
}
