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
            vm.isShuffleModeEnabled.toggle()
        } label: {
            HStack(spacing: 0) {
                Image("shuffle")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 14)
                    .foregroundColor(Color.accent)
                Text("Shuffle")
                    .foregroundColor(vm.isShuffleModeEnabled ? Color.white.opacity(0.5) : Color.white)
                    .shuffleAndSortFont()
                    .padding(.leading, 8)                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 13)
            .frame(maxWidth: .infinity)
            .background(Color.accent.opacity(0.2))
            .cornerRadius(30)
        }
    }
}


// MARK: - Preview
#Preview {
    ShuffleButton()
        .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
        .environmentObject(RealmManager(name: "viewModel"))
        .environmentObject(ImportManager())
        .preferredColorScheme(.dark)
}
