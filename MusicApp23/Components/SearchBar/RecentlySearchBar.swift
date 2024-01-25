//
//  RecentlySearchBar.swift
//  MusicApp23
//
//  Created by Dima on 19.01.2024.
//

import SwiftUI

struct RecentlySearchBar: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    let magnifyingglass = Image(systemName: "magnifyingglass")
    
    // MARK: - Body
    var body: some View {
        HStack {
            HStack {
                TextField("\(magnifyingglass) Search", text: $vm.searchRecently)
                .multilineTextAlignment(.center)
                .accentColor(.accent)
                .colorMultiply(.white)
                .padding(8)
                .onChange(of: vm.searchRecently, perform: { _ in
                    vm.searchSongsByArtistRecently()
                })
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.accent, lineWidth: 1)
            )
            .frame(minHeight: 36, maxHeight: 36)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}
