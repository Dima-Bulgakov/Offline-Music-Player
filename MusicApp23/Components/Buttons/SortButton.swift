//
//  SortButton.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SortButton: View {
    
    // MARK: - Properties
    @State private var isShowSortMenu = false
    
    // MARK: - Body
    var body: some View {
        Button {
            self.isShowSortMenu.toggle()
        } label: {
            HStack(spacing: 0) {
                Image("sort")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17)
                Text("Sort By")
                    .shuffleAndSortFont()
                    .padding(.leading, 8)
                    .padding(.vertical, 10)
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            
            /// Shape
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.accent, lineWidth: 1)
            )
        }
        
        /// Pop Menu With Sorting
        .popover(isPresented: $isShowSortMenu, attachmentAnchor: .point(.bottom), content: {
            SortMenu()
        })
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SortButton()
        .preferredColorScheme(.dark)
}
