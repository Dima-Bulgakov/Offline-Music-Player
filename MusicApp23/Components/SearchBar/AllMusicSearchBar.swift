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
    @State private var isFocused: Bool = false
    
    let magnifyingglass = Image(systemName: "magnifyingglass")
    
    // MARK: - Body
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                /// TextField
                TextField("Search", text: $vm.searchAllMusic)
                    .multilineTextAlignment(.leading)
                    .accentColor(.white)
                    .foregroundColor(.white)
                    .padding(8)
            }
            .padding(.leading)
            .frame(height: 36)
            .background(Color.accent.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? Color.accent : Color.clear, lineWidth: 1)
            )
        }
        .padding(.horizontal)
        .padding(.top)
        .onTapGesture {
            self.isFocused = true
        }
    }
}


// MARK: - Preview
#Preview {
    AllMusicSearchBar()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
