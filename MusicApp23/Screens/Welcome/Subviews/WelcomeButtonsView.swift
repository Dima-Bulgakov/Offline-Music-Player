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
        GeometryReader { proxy in
            let size = proxy.size
            VStack(spacing: 18) {
                
                HStack(spacing: 18) {
                    
                    /// Files Import
                    WelcomButton(image: "filesW", title: "Files") {
                        importManager.isFilesPresented.toggle()
                    }
                    
                    /// Camera Roll Import
                    WelcomButton(image: "cameraW", title: "Camera Roll") {
//                        importManager.isPhotoPickerPresented.toggle()
                    }
                }
                
                HStack(spacing: 18) {
                    
                    /// App Sharing Import
                    WelcomButton(image: "appSharingW", title: "App Sharing") {
                        importManager.isShowShareAlert.toggle()
                    }
                    
                    /// Safari Import
                    WelcomButton(image: "safariW", title: "Safari") {
                        importManager.isShowSafariAlert.toggle()
                    }
                }
                
                /// Wi-Fi Transfer Import
                WelcomButton(image: "wifiW", title: "Wi-Fi Transfer") {
                    importManager.isShowWiFiTransferSheet.toggle()
                }
                BottomText()
                    .padding(.top)
            }
            .frame(height: size.height * 0.7)
        }
    }
}



#Preview {
    WelcomeButtonsView()
        .environmentObject(ViewModel())
        .environmentObject(VMImportManager())
        .preferredColorScheme(.dark)
}
