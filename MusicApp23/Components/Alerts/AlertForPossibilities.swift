//
//  AlertForPossibilities.swift
//  MusicApp23
//
//  Created by Dima on 04.02.2024.
//

import SwiftUI

/// Instruction Enum For Share And Safari Import
enum Instruction: String {
    case share = "Select share option\nin the app, Click More \nand copy to MusicApp23"
    case safari = "Safari instruction"
}

struct AlertForPossibilities: View {
    
    // MARK: - Properties
    let title: Instruction
    let image: String
    let action: () -> ()
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(title.rawValue)
                .foregroundColor(Color.primaryFont)
                .padding(.top)
                .padding(.bottom, 5)
                .multilineTextAlignment(.center)
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 230)
            Button("OK") {
                action()
            }
            .padding(.top, 5)
            .foregroundColor(.accent)
        }
        .padding(15)
        .background(Color.alert)
        .cornerRadius(20)
    }
}

//#Preview {
//    AlertForPossibilities(title: "Select share option in the app", image: "ACDC", action: {})
//        .preferredColorScheme(.dark)
//}
