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
            VStack {
                
                // MARK: - Subviews
                Bunner()
                SettingsList()
                VOIOLCC()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.bg)
        }
        // MARK: - NavigationBar
        .customNavigationTitle(title: "Settings")
    }
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
