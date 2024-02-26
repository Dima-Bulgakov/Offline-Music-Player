//
//  ContainerView.swift
//  MusicApp23
//
//  Created by Dima on 08.02.2024.
//

import SwiftUI

struct ContainerView: View {
    
    @State private var isLaunchScreenViewPresented = true
    
    var body: some View {
        if !isLaunchScreenViewPresented {
            ContentView()
        } else {
            LaunchScreen(isPresented: $isLaunchScreenViewPresented)
        }
    }
}

#Preview {
    ContainerView()
        .environmentObject(ViewModel())
        .environmentObject(VMImportManager())
        .preferredColorScheme(.dark)
}
