//
//  SettingsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SettingsList: View {
    
    // MARK: - Model For Cell
    struct SettingItem: Identifiable {
        let id = UUID()
        let image: String
        let title: String
        let action: () -> ()
    }
    
    // MARK: - Property
    
    /// Array With Settings Cells
    var settingsArray: [SettingItem] {
        [
            SettingItem(image: "report", title: "Report Bug") {
                email.send(openURL: openURL)
            },
            SettingItem(image: "rate", title: "Rate Us") {
                /// Link To App Store
            },
            SettingItem(image: "share", title: "Share App") {
                isSharing.toggle()
            },
            SettingItem(image: "privacy", title: "Privacy Policy") {
                /// Show Privacy Policy Action
            },
            SettingItem(image: "terms", title: "Terms of Use") {
                /// Show Terms Of Use Action
            }
        ]
    }
    
    /// Email Properties
    @Environment(\.openURL) var openURL
    private var email = SupportEmail(toAddress: "voio@gmail.com",
                                     subject: "Support Email",
                                     messageHeader: "Please describe your issue below")
    /// Share Properties
    @State private var isSharing = false
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: List Of Settings Cell
            List {
                ForEach(settingsArray) { item in
                    SettingListCell(image: item.image, title: item.title, action: item.action)
                        .listRowBackground(Color.bg)
                }
            }
            .listStyle(.plain)
            .frame(height: 330)
            
            // MARK: Sheets
            .sheet(isPresented: $isSharing) {
                ShareSheet(activityItems: [URL(string: "https://MusicApp23.com")!], applicationActivities: nil)
            }
        }
    }
}


#Preview {
    SettingsList()
        .preferredColorScheme(.dark)
}
