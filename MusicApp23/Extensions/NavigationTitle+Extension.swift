//
//  NavigationTitle+Extension.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

extension View {
    func customNavigationTitle(title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
