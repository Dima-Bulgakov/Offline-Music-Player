//
//  WelcomeView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct WelcomeView: View {
    
    @Environment (\.dismiss) private var dismiss
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack {
                VStack(alignment: .leading) {
                    
                    // MARK: - Subviews
                    WelcomeTitleView()
                    WelcomeButtonsView()
                }
                BottomText()
                Spacer()
                
                // MARK: - Navigation Bar
                .customBarButton(name: "crown", width: 36, height: 28, placement: .topBarLeading) {}
                .customBarButton(name: "question", width: 30, height: 30, placement: .topBarTrailing) {}
                .navigationBarBackButtonHidden(true)
                .customBarButton(name: "back", width: 40, height: 0, placement: .topBarLeading) { dismiss() }
            }
            .padding()
        }
    }
}

#Preview {
    WelcomeView()
        .preferredColorScheme(.dark)
}
