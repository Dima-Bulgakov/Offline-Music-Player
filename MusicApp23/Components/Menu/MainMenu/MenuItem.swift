//
//  MenuItem.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct MenuItem: View {
    
    // MARK: Properties
    let image: String
    let title: String
    let isSelected: Bool
    
    // MARK: Body
    var body: some View {
        VStack {
            HStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 10)
                Text(title)
                    .fontWeight(isSelected ? .bold : .regular)
            }
            .foregroundStyle(isSelected ? Color.accent : Color.black)
        }
    }
}

#Preview {
    MenuItem(image: "home", title: "Home", isSelected: true)
        .frame(height: 22)
        .padding()
        .background(.white)
        .preferredColorScheme(.dark)
}
