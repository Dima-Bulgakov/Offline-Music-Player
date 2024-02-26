//
//  LaunchScreen.swift
//  MusicApp23
//
//  Created by Dima on 08.02.2024.
//

import SwiftUI

struct LaunchScreen: View {
    
    // MARK: - Properties
    @Binding var isPresented: Bool
    @State var progress: CGFloat = 0.0
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Image("launchScreenBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image("launchScreenLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96)
                    .clipShape(RoundedCorners(cornerRadius: 25, corners: .allCorners))
                Spacer()
            }
            
            VStack {
                Spacer()
                
                // MARK: ProgressBar
                ProgressBar(initialProgress: $progress, color: Color.primaryFont)
                    .frame(height: 7)
                    .frame(maxWidth: .infinity)
                    .onReceive([self.progress].publisher) { _ in
                        if self.progress >= 1.0 {
                            self.isPresented = false
                        }
                    }
                    .padding(.bottom, 120)
                    .padding(.horizontal, 50)
            }
        }
        .onAppear {
            self.start()
        }
    }
    
    // MARK: Timer
    func start() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            self.progress += 0.05
        }
    }
}


// MARK: - Preview
#Preview {
    LaunchScreen(isPresented: .constant(true))
}
