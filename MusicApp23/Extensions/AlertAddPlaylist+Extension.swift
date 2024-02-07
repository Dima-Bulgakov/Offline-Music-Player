//
//  Alert+Extension.swift
//  MusicApp23
//
//  Created by Dima on 06.01.2024.
//

import UIKit
import SwiftUI

extension UIAlertController {
    static func customTextFieldAlert(completion: @escaping (String) -> Void, saveAction: @escaping () -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "Enter a new playlist name", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlist Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let text = alert.textFields?.first?.text else { return }
            completion(text)
            saveAction() // убедитесь, что вызывается saveActionHandler
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        return alert
    }
}

extension View {
    func alertView(myPlaylists: Binding<[PlaylistModel]>, saveActionHandler: @escaping () -> Void) {
        let alertController = UIAlertController.customTextFieldAlert { playlistName in

            let newPlaylist = PlaylistModel(name: playlistName, image: UIImage(imageLiteralResourceName: "noImagePlaylist"), songs: [])
            myPlaylists.wrappedValue.append(newPlaylist)

        } saveAction: {
            saveActionHandler()
        }
        
        if let viewController = UIApplication.shared.windows.first?.rootViewController {
            viewController.present(alertController, animated: true, completion: nil)
        }
    }
}


