//
//  SettingsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SettingsList: View {
    
    // MARK: - Body
    var body: some View {
        List {
            SettingListCell(image: "report", title: "Report Bug")
            SettingListCell(image: "rate", title: "Rate Us")
            SettingListCell(image: "share", title: "Share App")
            SettingListCell(image: "privacy", title: "Privacy Policy")
            SettingListCell(image: "terms", title: "Terms of Use")
        }
        .listStyle(PlainListStyle())
        .frame(height: 330)
    }
}

#Preview {
    SettingsList()
        .preferredColorScheme(.dark)
}
