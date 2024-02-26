//
//  PlaylistView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI
import RealmSwift


struct PlaylistView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    
    @Environment(\.presentationMode) var presentationMode
    @Environment (\.dismiss) private var dismiss
    
    @ObservedRealmObject var playlist: Playlist
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            // MARK: - Subviews
            Head(playlist: playlist)
            SongsList(playlist: playlist)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.bg)
        .navigationBarBackButtonHidden(true)
        
        // MARK: - NavigationBar
        .customNavigationTitle(title: playlist.name)
        
        /// Increasing The Popularity Of The Playlist At The Entrance
        .onAppear {
            self.incrementNumberOfListens(for: self.playlist)
            print("Playlist \(playlist.name): NunOfList: \(playlist.numberOfListens)")
        }
        
        /// Button To Create New Playlist
        .customBarButton(name: "add", width: 25, height: 17, placement: .topBarTrailing) {
            alertAddPlaylist(realmManager: self.rm) {
                vm.isShowAddToPlaylistView = true
            }
        }
        
        /// AddToPlaylistView Sheet
        NavigationLink(destination: AddToPlaylistView().onDisappear {
        },isActive: $vm.isShowAddToPlaylistView) {
            EmptyView()
        }
        .hidden()
        
        /// Back Button
        .customBarButton(name: "back", width: 40, height: 14, placement: .topBarLeading) {
            dismiss()
            vm.isEditModeInPlaylistShow = false
            vm.isPlayerPresented = true
        }
        
        // MARK: - DragGesture
        .gesture(DragGesture().onEnded { value in
            if value.translation.width > 100 {
                presentationMode.wrappedValue.dismiss()
            }
        })
    }
    
    // MARK: - Methods
    /// Method To Increase Playlist Popularity
    private func incrementNumberOfListens(for playlist: Playlist) {
        guard let realm = try? Realm(configuration: rm.appGroupRealmConfiguration()) else { return }
        do {
            try realm.write {
                guard let updatingPlaylist = realm.object(ofType: Playlist.self, forPrimaryKey: playlist.id) else { return }
                updatingPlaylist.numberOfListens += 1
            }
        } catch {
            print("Ошибка при увеличении количества прослушиваний: \(error)")
        }
    }
}


// MARK: - Preview
#Preview {
    PlaylistView(playlist: Playlist(name: ""))
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
