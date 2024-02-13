//
//  WelcomeView.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct WelcomeView: View {
    
    // MARK: - Properties
    @Environment (\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - Body
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                WelcomeTitleView()
                    VStack {
                        // MARK: - Subviews
                        WelcomeButtonsView()
                        Spacer()
                    }
                
                // MARK: - Navigation Bar
                .customBarButton(name: "crown", width: 36, height: 28, placement: .topBarLeading) {
                    
                }
                .customBarButton(name: "question", width: 30, height: 30, placement: .topBarTrailing) {
                    
                }
                .customBarButton(name: "back", width: 40, height: 14, placement: .topBarLeading) {
                    dismiss()
                }
                .gesture(DragGesture().onEnded { value in
                    if value.translation.width > 100 {
                        presentationMode.wrappedValue.dismiss()
                    }
                })
                .navigationBarBackButtonHidden(true)
            }
            .padding()
        }
        .customNavigationTitle(title: "Welcome")
    }
}

#Preview {
    NavigationView {
        WelcomeView()
            .environmentObject(VMImportManager())
        .preferredColorScheme(.dark)
    }
}
