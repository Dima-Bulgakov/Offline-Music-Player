//
//  ProgressBar.swift
//  MusicApp23
//
//  Created by Dima on 26.02.2024.
//

import SwiftUI


struct ProgressBar: View {
    
    // MARK: - Properties
    @Binding var progress: CGFloat
    
    private var barColor: Color
    private var animationTime: TimeInterval = 0.3
    
    
    // MARK: - Initializer
    public init(initialProgress: Binding<CGFloat>, color: Color) {
        self._progress = initialProgress
        self.barColor = color
    }
    
    // MARK: - Body
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
