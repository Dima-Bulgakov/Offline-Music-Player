//
//  SettingsView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI


struct SettingsView: View {
        
    // MARK: - Body
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let size = proxy.size
                VStack {
                    
                    // MARK: - Subviews
                    Bunner()
                        .frame(height: size.height * 0.22)
                    SettingsList()
                    VOIOLCC()
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.bg)
            }
        }
        // MARK: - Navigation Bar
        .customNavigationTitle(title: "Settings")
    }
}


// MARK: - Preview
#Preview {
    SettingsView()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
