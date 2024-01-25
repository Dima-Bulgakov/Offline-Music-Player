//
//  SearchBar.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct AllMusicSearchBar: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    let magnifyingglass = Image(systemName: "magnifyingglass")
    
    // MARK: - Body
    var body: some View {
        HStack {
            HStack {
                TextField("\(magnifyingglass) Search", text: $vm.searchAllMusic)
                .multilineTextAlignment(.center)
                .accentColor(.accent)
                .colorMultiply(.white)
                .padding(8)
                .onChange(of: vm.searchAllMusic, perform: { _ in
                    vm.searchSongsByArtist()
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

//#Preview {
//    SearchBar()
//        .environmentObject(ViewModel())
//        .preferredColorScheme(.dark)
//}
