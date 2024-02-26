//
//  ImportFileManager.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import SwiftUI
import UIKit
import AVFoundation


struct ImportFileManager: UIViewControllerRepresentable {
    
    // MARK: Properties
    @Binding var file: Data?
    @Binding var fileName: String?
    
    var vm: ViewModel
    var rm: RealmManager
    
    // MARK: Methods
    func makeCoordinator() -> ImportFileManager.Coordinator {
        return ImportFileManager.Coordinator(parent1: self, vm: vm, rm: rm)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImportFileManager>) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .open)
        picker.allowsMultipleSelection = false
        picker.shouldShowFileExtensions = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<ImportFileManager>) {
        
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        // MARK: Properties
        var parent: ImportFileManager
        var vm: ViewModel
        var rm: RealmManager
        
        // MARK: Initializer
        init(parent1: ImportFileManager, vm: ViewModel, rm: RealmManager) {
            self.parent = parent1
            self.vm = vm
            self.rm = rm
        }
        
        // MARK: Methods
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard controller.documentPickerMode == .open, let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            DispatchQueue.main.async {
                url.stopAccessingSecurityScopedResource()
            }
            do {
                let asset = AVAsset(url: url)
                let metadata = asset.commonMetadata
                
                var artist: String?
                var coverImageData: Data?
                var duration: TimeInterval?
                
                for item in metadata {
                    guard let commonKey = item.commonKey, let value = item.value else {
                        continue
                    }
                    
                    switch commonKey.rawValue {
                    case AVMetadataKey.commonKeyTitle.rawValue:
                        self.parent.fileName = value as? String ?? url.lastPathComponent
                    case AVMetadataKey.commonKeyArtwork.rawValue:
                        if let data = value as? Data {
                            coverImageData = data
                        }
                    case AVMetadataKey.commonKeyArtist.rawValue:
                        artist = value as? String
                    default:
                        break
                    }
                }
                
                let document = try Data(contentsOf: url.absoluteURL)
                self.parent.file = document
                
                duration = CMTimeGetSeconds(asset.duration)
                
                let fileNameToCheck = self.parent.fileName ?? url.lastPathComponent
                if let isDuplicate = self.rm.realm?.objects(Song.self).contains(where: { $0.name == fileNameToCheck }) {
                    if !isDuplicate {
                        self.rm.addSong(name: fileNameToCheck, data: document, artist: artist, coverImageData: coverImageData, duration: duration)
                    } else {
                        print("Song with the same name already exists.")
                    }
                }
                
            } catch {
                print("Error picking the file: \(error.localizedDescription)")
            }
        }
    }
}
