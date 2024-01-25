//
//  SongMeu.swift
//  MusicApp23
//
//  Created by Dima on 24.12.2023.
//

import SwiftUI

struct SongMenu: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                vm.addToFavorites()
            } label: {
                HStack {
                    Image("favoriteSM")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                    Text("Add to Favorite")
                        .songMenuFont()
                }
                .padding(.horizontal, 14)
            }
            Divider()
            Button {
                vm.isShowChoosePlaylistView = true
            } label: {
                HStack {
                    Image("playlistSM")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                    Text("Add to Playlist")
                        .songMenuFont()
                }
                .padding(.horizontal, 14)
                .sheet(isPresented: $vm.isShowChoosePlaylistView) {
                    ChoosePlaylistView()
                        .onDisappear {
                            vm.resetPlaylistSelection()
                        }
                }
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
        .frame(width: 175, height: 143)
        .background(Color.menu)
        .modifier(ConditionalCompactAdaptation())
    }
}

struct ConditionalCompactAdaptation: ViewModifier {
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if #available(iOS 16.4, *) {
            return content.presentationCompactAdaptation(.none)
        } else {
            return content
        }
    }
}


#Preview {
    SongMenu()
        .environmentObject(ViewModel())
}
