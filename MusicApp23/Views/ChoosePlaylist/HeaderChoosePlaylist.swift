//
//  HeaderChoosePlaylist.swift
//  MusicApp23
//
//  Created by Dima on 07.01.2024.
//

import SwiftUI


struct HeaderChoosePlaylist: View {
    
    // MARK: - Properties
    @Environment (\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            
            // MARK: Title
            Text("Choose Playlist")
                .tabBarFont()
                .frame(maxWidth: .infinity)
        }
        
        // MARK: Cancel Button
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image("cancel")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 56)
                    .foregroundColor(Color.accent)
            }
            .padding(.top, 8)
        }
        .padding()
    }
}


// MARK: - Preview
#Preview {
    HeaderChoosePlaylist()
}
