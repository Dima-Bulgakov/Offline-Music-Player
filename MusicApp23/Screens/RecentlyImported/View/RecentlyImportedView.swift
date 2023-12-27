//
//  RecentlyImportedView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct RecentlyImportedView: View {
    
    // MARK: - Properties
//    @State var searchText: String = ""
    @Environment (\.dismiss) private var dismiss
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
                RecentlyList()
                    .padding()
            }
            .background(Color.bg)
            
            // MARK: - Navigation Bar
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Recently Imported")
            .customBarButton(name: "back", width: 40, height: 0, placement: .topBarLeading) { dismiss() }
            .customBarButton(name: "twoArrow", width: 25, height: 0, placement: .topBarTrailing) { vm.reverseOrder() }
        }
    }
}

#Preview {
    RecentlyImportedView()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
