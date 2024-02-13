//
//  ShareSheet.swift
//  MusicApp23
//
//  Created by Dima on 04.02.2024.
//

import SwiftUI

// MARK: - Sheet For Share App in Settings
struct ShareSheet: UIViewControllerRepresentable {
    
    // MARK: Properties
    typealias UIViewControllerType = UIActivityViewController

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    // MARK: Methods
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        activityViewController.modalPresentationStyle = .popover
        activityViewController.popoverPresentationController?.permittedArrowDirections = .down
        activityViewController.popoverPresentationController?.sourceView = UIView()
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No need to update the view controller
    }
}
