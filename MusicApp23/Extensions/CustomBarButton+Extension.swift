//
//  CustomBarButton+Extension.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI


extension View {
    func customBarButton(name: String, width: CGFloat, height: CGFloat, placement: ToolbarItemPlacement, action: @escaping () -> Void) -> some View {
        toolbar {
            ToolbarItem(placement: placement) {
                Button(action: action) {
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: height)
                        .foregroundColor(Color.accent)
                }
            }
        }
    }
}
