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
            Button {
                vm.sortSongsByArtist()
            } label: {
                HStack {
                    Image("artist")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                    Text("Artist (A-z)")
                        .songMenuFont()
                    
                }
                .padding(.horizontal, 14)
            }
            Divider()
            Button {
                vm.sortSongsByTitle()
            } label: {
                HStack {
                    Image("title")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                    Text("Title (A-z)")
                        .songMenuFont()
                }
                .padding(.horizontal, 14)
            }
            Divider()
            Button {
                // Add Action
            } label: {
                HStack {
                    Image("date")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                    Text("Date")
                        .songMenuFont()
                }
                .padding(.horizontal, 14)
            }
            Divider()
            Button {
                vm.sortSongsByDuration()
            } label: {
                HStack {
                    Image("duration")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 18)
                        .padding(.trailing, 8)
                        .padding(.vertical, 5)
                    Text("Duration")
                        .songMenuFont()
                }
                .padding(.horizontal, 14)
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
