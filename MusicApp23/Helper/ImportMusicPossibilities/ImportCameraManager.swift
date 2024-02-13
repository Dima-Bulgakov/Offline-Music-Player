//
//  ImagePicker.swift
//  MusicApp23
//
//  Created by Dima on 04.01.2024.
//

import SwiftUI
import AVKit
import AVFoundation
import MobileCoreServices

struct ImportCameraManager: UIViewControllerRepresentable {

    // MARK: - Properties
    @Environment(\.presentationMode) private var presentationMode
    @Binding private var audioPlayer: AVAudioPlayer?
    var vm: ViewModel

    // MARK: - Initializer
    init(audioPlayer: Binding<AVAudioPlayer?>, vm: ViewModel, onAudioLoaded: @escaping (String) -> Void) {
        _audioPlayer = audioPlayer
        self.vm = vm
    }

    // MARK: - Methods
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImportCameraManager>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        
        // Устанавливаем все доступные типы медиа
        picker.mediaTypes = [kUTTypeMovie as String]
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImportCameraManager>) {}

    // MARK: - Class Coordinator
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        // MARK: Properties
        let parent: ImportCameraManager
        var isConvertingAudio = false

        // MARK: Initializer
        init(_ parent: ImportCameraManager) {
            self.parent = parent
        }

        // MARK: Methods
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let mediaURL = info[.mediaURL] as? URL {
                convertVideoToAudio(url: mediaURL)
            }

            parent.presentationMode.wrappedValue.dismiss()
        }

        private func convertVideoToAudio(url: URL) {
            guard !isConvertingAudio else {
                print("Conversion already in progress.")
                return
            }

            isConvertingAudio = true

            let asset = AVAsset(url: url)

            do {
                let audioFileName = UUID().uuidString
                let temporaryDirectory = FileManager.default.temporaryDirectory
                let audioFilePath = temporaryDirectory.appendingPathComponent(audioFileName)

                guard let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetAppleM4A) else {
                    print("Failed to create AVAssetExportSession.")
                    isConvertingAudio = false
                    return
                }

                exporter.outputFileType = AVFileType.m4a
                exporter.outputURL = audioFilePath

                exporter.exportAsynchronously {
                    if exporter.status == .completed {
                        do {
                            let audioData = try Data(contentsOf: audioFilePath)

                            DispatchQueue.main.async {
                                let duration = CMTimeGetSeconds(asset.duration)
                                self.parent.vm.addSong(name: audioFileName, data: audioData, artist: nil, coverImageData: nil, duration: duration)
                            }
                        } catch {
                            print("Error creating or playing audio player: \(error)")
                        }
                    } else {
                        print("Failed to export audio: \(exporter.error?.localizedDescription ?? "")")
                    }

                    self.isConvertingAudio = false
                }

            } catch {
                print("Error: \(error)")
                isConvertingAudio = false
            }
        }
    }
}

//struct ImportCameraManager: UIViewControllerRepresentable {
//
//    // MARK: - Properties
//    @Environment(\.presentationMode) private var presentationMode
//    @Binding private var audioPlayer: AVAudioPlayer?
//    var vm: ViewModel
//
//    // MARK: - Initializer
//    init(audioPlayer: Binding<AVAudioPlayer?>, vm: ViewModel, onAudioLoaded: @escaping (String) -> Void) {
//        _audioPlayer = audioPlayer
//        self.vm = vm
//    }
//
//    // MARK: - Methods
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImportCameraManager>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.mediaTypes = ["public.movie"]
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImportCameraManager>) {}
//
//    // MARK: - Class Coordinator
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        
//        // MARK: Properties
//        let parent: ImportCameraManager
//        var isConvertingAudio = false
//
//        // MARK: Initializer
//        init(_ parent: ImportCameraManager) {
//            self.parent = parent
//        }
//
//        // MARK: Methods
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let mediaURL = info[.mediaURL] as? URL {
//                convertVideoToAudio(url: mediaURL)
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//
//        private func convertVideoToAudio(url: URL) {
//            guard !isConvertingAudio else {
//                print("Conversion already in progress.")
//                return
//            }
//
//            isConvertingAudio = true
//
//            let asset = AVAsset(url: url)
//
//            do {
//                let audioFileName = UUID().uuidString
//                let temporaryDirectory = FileManager.default.temporaryDirectory
//                let audioFilePath = temporaryDirectory.appendingPathComponent(audioFileName)
//
//                let exporter = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetPassthrough)
//
//                guard exporter != nil else {
//                    print("Failed to create AVAssetExportSession.")
//                    isConvertingAudio = false  // В случае ошибки сбрасываем флаг
//                    return
//                }
//
//                exporter!.outputFileType = AVFileType.m4a
//                exporter!.outputURL = audioFilePath
//
//                exporter!.exportAsynchronously {
//                    if exporter!.status == .completed {
//                        do {
//                            let audioData = try Data(contentsOf: audioFilePath)
//
//                            DispatchQueue.main.async {
//                                let duration = CMTimeGetSeconds(asset.duration)
//                                self.parent.vm.addSong(name: audioFileName, data: audioData, artist: nil, coverImageData: nil, duration: duration)
//                            }
//                        } catch {
//                            print("Error creating or playing audio player: \(error)")
//                        }
//                    } else {
//                        print("Failed to export audio: \(exporter!.error?.localizedDescription ?? "")")
//                    }
//
//                    self.isConvertingAudio = false
//                }
//            } catch {
//                print("Error: \(error)")
//                isConvertingAudio = false
//            }
//        }
//    }
//}
