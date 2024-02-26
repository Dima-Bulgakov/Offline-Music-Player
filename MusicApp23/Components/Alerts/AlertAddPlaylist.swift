//
//  Alert+Extension.swift
//  MusicApp23
//
//  Created by Dima on 06.01.2024.
//

import UIKit
import SwiftUI


// MARK: - Alert For Additing Playlists
extension UIAlertController {
    static func customTextFieldAlert(completion: @escaping (String?) -> Void, saveAction: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Enter a new playlist name", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlist Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let text = alert.textFields?.first?.text else { return }
            completion(text)
            saveAction()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        return alert
    }
}

// MARK: - Extension For View To Show Alert For Adding Playlist
extension View {
    func alertAddPlaylist(realmManager: RealmManager, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Enter a new playlist name", message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Playlist Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let name = alertController.textFields?.first?.text, !name.isEmpty else { return }
            
            let newPlaylist = Playlist()
            newPlaylist.name = name
            realmManager.addPlaylist(newPlaylist)
            
            completion()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}

