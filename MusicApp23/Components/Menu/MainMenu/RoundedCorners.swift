//
//  RoundedCorners.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI


struct RoundedCorners: Shape {
    
    // MARK: - Properties
    var cornerRadius: CGFloat
    var corners: UIRectCorner
    
    // MARK: - Methods
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topLeft = corners.contains(.topLeft)
        let topRight = corners.contains(.topRight)
        let bottomLeft = corners.contains(.bottomLeft)
        let bottomRight = corners.contains(.bottomRight)
        
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width, y: height - cornerRadius))
        
        if topRight {
            path.addArc(center: CGPoint(x: width - cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: width, y: height - cornerRadius))
        }
        
        if topLeft {
            path.addArc(center: CGPoint(x: cornerRadius, y: height - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0, y: height))
        }
        
        if bottomLeft {
            path.addArc(center: CGPoint(x: cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        
        if bottomRight {
            path.addArc(center: CGPoint(x: width - cornerRadius, y: cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        } else {
            path.addLine(to: CGPoint(x: width, y: 0))
        }
        
        return path
    }
}
