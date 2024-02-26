//
//  Bunner.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI


struct Bunner: View {
    
    // MARK: - Body
    var body: some View {
        Color.bunner
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
            .padding()
            .overlay {
                Text("Get Pro Bunner")
                    .getBunnerFont()
            }
    }
}

// MARK: - Preview
#Preview {
    Bunner()
}
