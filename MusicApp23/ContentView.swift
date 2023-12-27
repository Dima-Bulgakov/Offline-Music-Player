//
//  ContentView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct ContentView: View {

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            MainMenu()
                .zIndex(1)
            PlayerView()
                .offset(y: 30)
                .zIndex(2)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
