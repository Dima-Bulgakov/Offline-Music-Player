//
//  PlaylistMenu.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI

struct PlaylistMenu: View {
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                // Add Action
            } label: {
                HStack {
                    Image(systemName: "pencil")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                        .foregroundColor(Color.accent)
                    Text("Rename")
                        .songMenuFont()
                }
                .padding(.horizontal, 14)
            }
            Divider()
            Button {
                // Add Action
            } label: {
                HStack {
                    Image("deleteSM")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                    Text("Delete")
                        .songMenuFont()
                }
                .padding(.horizontal, 14)
            }
        }
        .frame(width: 175, height: 95)
        .background(Color.menu)
        .modifier(ConditionalCompactAdaptation())
    }
}

#Preview {
    PlaylistMenu()
        .preferredColorScheme(.dark)
}
