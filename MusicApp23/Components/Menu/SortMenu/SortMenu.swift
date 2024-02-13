//
//  SortMenu.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI

struct SortMenu: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            // MARK: Sorting By Artist
            CustomeMenuButton(image: "artist", text: "Artist (A-z)") {
                vm.sortSongsByArtist()
            }
            Divider()
            
            // MARK: Sorting By Title
            CustomeMenuButton(image: "title", text: "Title (A-z)") {
                vm.sortSongsByTitle()
            }
            Divider()
            
            // MARK: Sorting By Date
            CustomeMenuButton(image: "date", text: "Date") {
                vm.sortSongsByDate()
            }
            Divider()
            
            // MARK: Sorting By Duration
            CustomeMenuButton(image: "duration", text: "Duration") {
                vm.sortSongsByDuration()
            }
        }
        .frame(width: 175, height: 168)
        .background(Color.menu)
        .modifier(ConditionalCompactAdaptation())
    }
}

#Preview {
    SortMenu()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
