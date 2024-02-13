//
//  ShuffleButton.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct ShuffleButton: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Body
    var body: some View {
        Button {
            vm.shuffleSongs()
        } label: {
            HStack(spacing: 0) {
                Image("shuffle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 17)
                    .foregroundColor(Color.primaryFont)
                Text("Shuffle")
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
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ShuffleButton()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
