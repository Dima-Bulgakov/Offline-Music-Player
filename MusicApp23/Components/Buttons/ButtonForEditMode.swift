//
//  ButtonForEditMode.swift
//  MusicApp23
//
//  Created by Dima on 25.01.2024.
//

import SwiftUI

struct ButtonForEditMode: View {
    
    let name: String
    let width: CGFloat
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(name)
                .resizable()
                .scaledToFit()
                .frame(width: width)
        }
    }
}

//#Preview {
//    ButtonForEditMode()
//}
