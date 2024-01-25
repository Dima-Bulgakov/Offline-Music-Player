//
//  SettingsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SettingsList: View {
    
    // MARK: - Model
    struct SettingItem: Identifiable {
        let id = UUID()
        let image: String
        let title: String
    }
    
    // MARK: - Property
    let settingsArray: [SettingItem] = [
        SettingItem(image: "report", title: "Report Bug"),
        SettingItem(image: "rate", title: "Rate Us"),
        SettingItem(image: "share", title: "Share App"),
        SettingItem(image: "privacy", title: "Privacy Policy"),
        SettingItem(image: "terms", title: "Terms of Use")
    ]
    
    // MARK: - Body
    var body: some View {
        VStack {
            List {
                ForEach(settingsArray) { item in
                    SettingListCell(image: item.image, title: item.title)
                        .listRowBackground(Color.bg)
                }
            }
            .listStyle(.plain)
            .frame(height: 330)
        }
    }
}

#Preview {
    SettingsList()
        .preferredColorScheme(.dark)
}
