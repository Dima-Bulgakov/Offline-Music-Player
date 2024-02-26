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
                RecentlySearchBar()
                
                HStack(spacing: 16) {
                    ShuffleButton()
                    SortButtonRecentlyImported()
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
            .customBarButton(name: "back", width: 40, height: 14, placement: .topBarLeading) {
                vm.searchRecently = ""
                dismiss()
            }
            .customBarButton(name: "twoArrow", width: 25, height: 21, placement: .topBarTrailing) {
                vm.searchRecently = ""
                vm.reverseOrder()
            }
        }
        .padding(.bottom, 130)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    NavigationView {
        RecentlyImportedView()
            .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
    }
}
