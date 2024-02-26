//
//  SortMenu.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI


struct SortMenuAllMusic: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Sorting By Artist
            CustomeMenuButton(image: "artist", text: "Artist (A-z)") {
                vm.currentSortAllSongs = .artist
                vm.isShowSortMenuAllMusic = false
            }
            Divider()
            
            // MARK: Sorting By Title
            CustomeMenuButton(image: "title", text: "Title (A-z)") {
                vm.currentSortAllSongs = .name
                vm.isShowSortMenuAllMusic = false
            }
            Divider()
            
            // MARK: Sorting By Date
            CustomeMenuButton(image: "date", text: "Date") {
                vm.currentSortAllSongs = .date
                vm.isShowSortMenuAllMusic = false
            }
            Divider()
            
            // MARK: Sorting By Duration
            CustomeMenuButton(image: "duration", text: "Duration") {
                vm.currentSortAllSongs = .duration
                vm.isShowSortMenuAllMusic = false
            }
        }
        .frame(width: 175, height: 168)
        .background(Color.menu)
        .modifier(ConditionalCompactAdaptation())
    }
}
