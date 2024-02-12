//
//  LaunchScreen.swift
//  MusicApp23
//
//  Created by Dima on 08.02.2024.
//

import SwiftUI

struct LaunchScreen: View {
    
    @Binding var isPresented: Bool
    @State private var imageOpacity = 1.0
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.launchScreen.ignoresSafeArea()
            
            ZStack {
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .opacity(imageOpacity)
                    
                    ProgressBar(initialProgress: $progress, color: Color.primaryFont)
                        .frame(height: 8)
                        .onReceive([self.progress].publisher) { _ in
                            if self.progress >= 1.0 {
                                // Когда анимация загрузки завершена, устанавливаем isPresented в false
                                self.isPresented = false
                            }
                        }
                }
            }
            .scaleEffect(scale)
            .onAppear {
                self.start()
            }
        }
    }
    func start() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { timer in
            self.progress += 0.05
        }
    }

}

struct ProgressBar: View {
    
    @Binding var progress: CGFloat
    
    private var barColor: Color
    private var animationTime: TimeInterval = 0.3
    
    public init(initialProgress: Binding<CGFloat>, color: Color) {
        self._progress = initialProgress
        self.barColor = color
    }
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(barColor.opacity(0.3))
                
                Rectangle()
                    .fill(barColor)
                    .frame(width: min(geo.size.width, geo.size.width * progress))
                    .animation(.linear)
            }
            .cornerRadius(25.0)
        }
    }
}


#Preview {
    LaunchScreen(isPresented: .constant(true))
}
