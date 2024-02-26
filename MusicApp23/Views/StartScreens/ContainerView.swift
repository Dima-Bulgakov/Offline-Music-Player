//
//  ContainerView.swift
//  MusicApp23
//
//  Created by Dima on 08.02.2024.
//

import SwiftUI

struct ContainerView: View {
    
    // MARK: - Properties
    @State private var isLaunchScreenViewPresented = true
    
    // MARK: - Body
    var body: some View {
        if !isLaunchScreenViewPresented {
            ContentView()
        } else {
            LaunchScreen(isPresented: $isLaunchScreenViewPresented)
        }
    }
}


// MARK: - Preview
#Preview {
    ContainerView()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
