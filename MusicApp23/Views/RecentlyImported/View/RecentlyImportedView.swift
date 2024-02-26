//
//  RecentlyImportedView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI


struct RecentlyImportedView: View {
    
    // MARK: - Properties
    @Environment (\.dismiss) private var dismiss
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                
                // MARK: - Subviews
                RecentlyMusicSearchBar()
                
                HStack(spacing: 16) {
                    ShuffleButton()
                    SortButtonRecentlyImported()
                }
                .padding(.top, 14)
                .padding(.horizontal)
                
                RecentlyImportedList()
                    .padding()
            }
            .background(Color.bg)
            
            // MARK: - Navigation Bar
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Recently Imported")
            .customBarButton(name: "back", width: 40, height: 14, placement: .topBarLeading) {
                vm.searchRecently = ""
                dismiss()
            }
            
            /// Reverse Button
            .customBarButton(name: "reverse", width: 25, height: 21, placement: .topBarTrailing) {
                vm.searchRecently = ""
                vm.currentSortRecently = .reverse
                vm.isReverseRecentlyMusicEnable.toggle()
            }
        }
        .padding(.bottom, 130)
        .ignoresSafeArea(.keyboard)
    }
}


// MARK: - Preview
#Preview {
    NavigationView {
        RecentlyImportedView()
            .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
            .environmentObject(RealmManager(name: "viewModel"))
            .environmentObject(ImportManager())
            .preferredColorScheme(.dark)
    }
}
