//
//  GestureManager.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

// MARK: - Gesture Manager For TabView
// What if user scrolled vastly when the offset don't reach 0.
// WorkAround: detecting if user touch the screen, then setting is tapped to false
final class GestureManager: NSObject, ObservableObject, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    @Published var isInteracting: Bool = false
    @Published var isGestureAdded: Bool = false
    
    // MARK: - Methods
    func addGesture() {
        if !isGestureAdded {
            let gesture = UIPanGestureRecognizer(target: self, action: #selector(onChange))
            gesture.name = "UNIVERSAL"
            gesture.delegate = self
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            
            guard let window = windowScene.windows.last?.rootViewController else { return }
            window.view.addGestureRecognizer(gesture)
            isGestureAdded = true
        }
    }
    
    func removeGesture() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let window = windowScene.windows.last?.rootViewController else { return }
        
        window.view.gestureRecognizers?.removeAll(where: { gesture in
            return gesture.name == "UNIVERSAL"
        })
        isGestureAdded = false
    }
    
    @objc func onChange(gesture: UIPanGestureRecognizer) {
        isInteracting = (gesture.state == .changed)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
