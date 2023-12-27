//
//  MyNusicView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct MyMusicView: View {
    
    // MARK: - Properties
//    @State var searchText: String = ""
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                
                // MARK: - Subviews
                SearchBar()
                HStack(spacing: 16) {
                    ShuffleButton()
                    SortButton()
                }
                .padding(.top, 14)
                .padding(.horizontal)
                MusicList()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.bg)
        }
        
        // MARK: - NavigationBar
        .customNavigationTitle(title: "My Music")
        .customBarButton(name: "twoArrow", width: 25, height: 17, placement: .topBarTrailing) {
            vm.reverseOrder()
        }
        
    }
}

#Preview {
    NavigationView {
        MyMusicView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
