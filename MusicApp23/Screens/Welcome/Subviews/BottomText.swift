//
//  BottomText.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct BottomText: View {
    
    // MARK: - Body
    var body: some View {
        Text("Please import music \nto starting use the app")
            .descriptionFont()
            .padding(.top, 30)
    }
}

#Preview {
    BottomText()
        .preferredColorScheme(.dark)
}
