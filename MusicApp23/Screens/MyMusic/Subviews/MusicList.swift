//
//  MusicList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct MusicList: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @State var selectedRow = Set<UUID>()
    @State private var editMode: EditMode = .inactive
    
    // MARK: - Body
    var body: some View {
        List(selection: $selectedRow) {
            ForEach(vm.songs) { song in
                HStack {
                    ArtistCellWithDuration(songModel: song)
                }
                .listRowBackground(Color.bg)
                
            }
//            .onDelete(perform: vm.deleteSong)
            .listRowSeparator(.hidden)
        }
        .listStyle(PlainListStyle())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                EditButton()
                    .foregroundColor(Color.accent)
            }
        }
        .environment(\.editMode, $editMode)
    }
}

#Preview {
    MusicList()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
