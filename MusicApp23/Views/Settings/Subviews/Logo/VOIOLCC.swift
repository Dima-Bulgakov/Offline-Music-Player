//
//  VOIOLCC.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct VOIOLCC: View {
    
    // MARK: - Body
    var body: some View {
        Image("voio")
            .resizable()
            .scaledToFit()
            .frame(width: 81)
            .padding(.top, 20)
    }
}

#Preview {
    VOIOLCC()
        .preferredColorScheme(.dark)
}
