//
//  Head.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct Head: View {
    
    // MARK: - Properties
    var playlist: PlaylistModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            
            // MARK: - Image
            Image(playlist.img)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            VStack(alignment: .leading) {
                
                // MARK: - Description
                Text(playlist.name)
                    .titleFont()
                Text("\(playlist.count) Songs")
                    .descriptionFont()
                
                // MARK: - Shuffle Button
                SortButton()
                    .padding(.top)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    Head(playlist: PlaylistModel(img: "playlist1", name: "Workout", count: 23, songs: []))
}
