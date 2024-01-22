//
//  AddShoppingListScreen.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//


import SwiftUI
import UIKit
import AVFoundation


// MARK: - File Downloader
struct ImportFileManager: UIViewControllerRepresentable {
    
    // MARK: Properties
    @Binding var songs: [SongModel]
    @Binding var file: Data?
    @Binding var fileName: String?
    var vm: ViewModel
    
    // MARK: Methods
    func makeCoordinator() -> ImportFileManager.Coordinator {
        return ImportFileManager.Coordinator(parent1: self, vm: vm)
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
        
        // MARK: Initializer
        init(parent1: ImportFileManager, vm: ViewModel) {
            self.parent = parent1
            self.vm = vm
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
                let isDuplicate = self.parent.songs.contains { $0.name == (self.parent.fileName ?? "") }
                
                if !isDuplicate {
                    vm.addSong(name: self.parent.fileName ?? url.lastPathComponent, data: document, artist: artist, coverImageData: coverImageData, duration: duration)
                } else {
                    print("Song with the same name already exists.")
                }
            } catch {
                print("Error picking the file: \(error.localizedDescription)")
            }
        }
    }
}
