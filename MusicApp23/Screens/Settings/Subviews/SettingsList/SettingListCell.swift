//
//  SettingListCell.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SettingListCell: View {
    
    // MARK: - Properties
    let image: String
    let title: String
    let action: () -> ()
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                
                // MARK: - Image
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22)
                    .padding(9)
                    .background(
                        Circle()
                            .foregroundStyle(Color.bunner)
                    )
                    .padding(.trailing, 9)
                
                // MARK: - Title
                Text(title)
                    .nameFont()
                Spacer()
                
                // MARK: - Arrow
                Image("arrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8)
            }
        }
        .background(Color.bg)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    SettingListCell(image: "report", title: "Report Bug", action: {})
        .preferredColorScheme(.dark)
}
