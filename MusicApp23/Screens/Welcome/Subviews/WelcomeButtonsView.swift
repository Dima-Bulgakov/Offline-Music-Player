//
//  WelcomeButtonsView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct WelcomeButtonsView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var importManager: VMImportManager
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 18) {
            HStack(spacing: 18) {
                WelcomButton(image: "filesW", title: "Files") { importManager.isFilesPresented.toggle() }
                WelcomButton(image: "cameraW", title: "Camera Roll") { importManager.isPhotoPickerPresented.toggle() }
            }
            HStack(spacing: 18) {
                WelcomButton(image: "appSharingW", title: "App Sharing") {}
                WelcomButton(image: "safariW", title: "Safari") {}
            }
            WelcomButton(image: "wifiW", title: "Wi-Fi Transfer") {}
            WelcomButton(image: "pcImportW", title: "PC Import") {}
        }
    }
}

#Preview {
    WelcomeButtonsView()
        .environmentObject(ViewModel())
        .environmentObject(VMImportManager())
        .preferredColorScheme(.dark)
}
