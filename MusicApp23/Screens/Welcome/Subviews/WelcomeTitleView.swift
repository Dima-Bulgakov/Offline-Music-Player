//
//  WelcomeTitleView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct WelcomeTitleView: View {
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Add Your Music")
                .titleFont()
        }
        .padding(.vertical)
    }
}

#Preview {
    WelcomeTitleView()
        .preferredColorScheme(.dark)
}
