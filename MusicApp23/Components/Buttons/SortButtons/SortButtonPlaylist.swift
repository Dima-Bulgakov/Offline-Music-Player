//
//  SortButtonPlaylist.swift
//  MusicApp23
//
//  Created by Dima on 26.02.2024.
//

import SwiftUI


struct SortButtonPlaylist: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    let playlist: Playlist
    
    // MARK: - Body
    var body: some View {
        Button {
            vm.isShowSortMenuPlaylist.toggle()
        } label: {
            HStack(spacing: 0) {
                Image("sort")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .foregroundColor(Color.accent)
                Text("Sort By")
                    .shuffleAndSortFont()
                    .padding(.leading, 8)
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 13)
            .frame(maxWidth: .infinity)
            .background(Color.accent.opacity(0.2))
            .cornerRadius(30)
        }
        
        /// Pop Menu With Sorting
        .popover(isPresented: $vm.isShowSortMenuPlaylist, attachmentAnchor: .point(.bottom), content: {
            SortMenuPlaylist()
        })
        .frame(maxWidth: .infinity)
    }
}
