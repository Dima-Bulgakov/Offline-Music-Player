//
//  SortButton.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SortButtonAllMusic: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        Button {
            vm.isShowSortMenuAllMusic.toggle()
        } label: {
            HStack(spacing: 0) {
                Image("sort")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .foregroundColor(Color.accent)
                Text("Sort By")
                    .shuffleAndSortFont()
                    .padding(.leading, 8)
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 13)
            .frame(maxWidth: .infinity)
            .background(Color.accent.opacity(0.2))
            .cornerRadius(30)
        }
        
        /// Pop Menu With Sorting
        .popover(isPresented: $vm.isShowSortMenuAllMusic, attachmentAnchor: .point(.bottom), content: {
            SortMenuAllMusic()
        })
        .frame(maxWidth: .infinity)
    }
}


