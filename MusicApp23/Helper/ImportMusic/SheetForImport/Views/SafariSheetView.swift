//
//  SafariSheetView.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import SwiftUI


struct SafariSheetView: View {
    
    // MARK: - Properties
    let shareIcon = "shareIcon"
    @Environment (\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.bg.ignoresSafeArea()
            VStack(spacing: 40) {
                Text("Safari import")
                    .importBySharingTitleFont()
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    CustomShareText(text: "Select file that you want to import")
                    
                    HStack {
                        Spacer()
                        Image("instructionShareImage1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 220, height: 67)
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color.accent)
                        Text("Press")
                        Image(shareIcon)
                            .resizable()
                            .frame(width: 18, height: 22)
                            .foregroundColor(Color.accentColor)
                        Text("button (Share)")
                    }
                    
                    CustomShareText(text: "Scroll your apps until option “More”")
                    
                    HStack {
                        Spacer()
                        Image("instructionShareImage2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 199, height: 54)
                        Spacer()
                    }
                    
                    CustomShareText(text: "Select “Music Player Offline\nin the app list")
                    
                    HStack {
                        Spacer()
                        Image("instructionShareImage3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 246, height: 109)
                        Spacer()
                    }
                }
                
                // MARK: - Continue Button
                Button {
                    dismiss()
                } label: {
                    Text("Continue")
                        .playlistButtonsFont()
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.accent)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 50)
        }
    }
}


// MARK: - Preview
#Preview {
    ShareSheetView()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
