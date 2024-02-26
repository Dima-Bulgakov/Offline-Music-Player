//
//  SortMenuPlaylist.swift
//  MusicApp23
//
//  Created by Dima on 26.02.2024.
//

import SwiftUI


struct SortMenuPlaylist: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Sorting By Artist
            CustomeMenuButton(image: "artist", text: "Artist (A-z)") {
                vm.currentSortPlaylist = .artist
                vm.isShowSortMenuPlaylist = false
            }
            Divider()
            
            // MARK: Sorting By Title
            CustomeMenuButton(image: "title", text: "Title (A-z)") {
                vm.currentSortPlaylist = .name
                vm.isShowSortMenuPlaylist = false
            }
            Divider()
            
            // MARK: Sorting By Date
            CustomeMenuButton(image: "date", text: "Date") {
                vm.currentSortPlaylist = .date
                vm.isShowSortMenuPlaylist = false
            }
            Divider()
            
            // MARK: Sorting By Duration
            CustomeMenuButton(image: "duration", text: "Duration") {
                vm.currentSortPlaylist = .duration
                vm.isShowSortMenuPlaylist = false
            }
        }
        .frame(width: 175, height: 168)
        .background(Color.menu)
        .modifier(ConditionalCompactAdaptation())
    }
}
