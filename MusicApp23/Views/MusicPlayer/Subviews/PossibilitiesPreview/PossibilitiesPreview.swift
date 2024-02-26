//
//  Possibilities.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI


struct PossibilitiesPreview: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var importManager: ImportManager
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                
                // MARK: - Title
                Text("Add Your Music")
                    .titleFont()
                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 10)
            
            // MARK: - Buttons
            LazyVGrid(columns: columns, spacing: 10) {
                PossibilitiesButton(image: "files", title: "Files") {
                    importManager.isFilesPresented.toggle()
                }
                PossibilitiesButton(image: "cameraRoll", title: "Camera Roll", showsSpacer: true) {
                    importManager.isPhotoPickerPresented.toggle()
                }
                PossibilitiesButton(image: "appSharing", title: "App Sharing", showsSpacer: true) {
                    importManager.isShowShareAlert.toggle()
                }
                PossibilitiesButton(image: "safari", title: "Safari", showsSpacer: true) {
                    importManager.isShowSafariAlert.toggle()
                }
            }
            PossibilitiesButton(image: "wifiTransfer", title: "Wi-Fi Transfer", showsSpacer: false) {
                importManager.isShowWiFiTransferSheet.toggle()
            }
        }
        .padding(.top, 25)
        .padding(.horizontal, 10)
    }
}
