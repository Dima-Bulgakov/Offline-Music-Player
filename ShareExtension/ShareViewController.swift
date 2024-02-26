//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Dima on 25.02.2024.
//

import UIKit
import Social
import SwiftUI
import UniformTypeIdentifiers
import RealmSwift
import AVFoundation


// MARK: - ShareViewController: Class Is Responsible For Processing The Data That Is Passed To The App When The User Clicks "Share"
class ShareViewController: UIViewController {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        isModalInPresentation = true
        
        if let itemProviders = (extensionContext?.inputItems.first as? NSExtensionItem)?.attachments {
            let realmManager = RealmManager(name: "example3")
            let shareView = ShareView(itemProviders: itemProviders, extensionContext: extensionContext)
                .environmentObject(realmManager)
            
            let hostingController = UIHostingController(rootView: shareView)
            hostingController.view.frame = self.view.frame
            self.view.addSubview(hostingController.view)
            self.addChild(hostingController)
        }
    }
}


// MARK: - ShareView
fileprivate struct ShareView: View {
    
    // MARK: - Properties
    var itemProviders: [NSItemProvider]
    var extensionContext: NSExtensionContext?
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var rm: RealmManager
    @State private var items: [ShareSongModel] = []
    
    // MARK: - Body
    var body: some View {
            GeometryReader { size in
                VStack {
                    
                    /// Header
                    HStack(alignment: .center) {
                        
                        /// Title
                        Text("Add to Offline Music Player")
                            .tabBarFont()
                            .frame(maxWidth: .infinity)
                        
                            /// Cancel Button
                            .overlay(alignment: .topLeading) {
                                Button {
                                    dismiss()
                                } label: {
                                    Text("Cancel")
                                        .frame(width: 56)
                                        .foregroundColor(Color.accent)
                                }
                                .padding(.top, 6)
                            }
                            .padding()
                    }
                    
                    // MARK: - List Of Songs
                    List {
                        ForEach(items) { song in
                            HStack(spacing: 14) {
                                
                                /// Image
                                if let coverImageData = song.cover, let uiImage = UIImage(data: coverImageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 50, height: 50)
                                        .background(Color.teal)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                } else {
                                    ZStack {
                                        Color.gray
                                            .frame(width: 50, height: 50)
                                        Image(systemName: "music.note")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: 30)
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                }
                                
                                /// Description
                                VStack(alignment: .leading) {
                                    Text(song.name)
                                        .artistFont()
                                        .foregroundColor(Color.white)
                                        .lineLimit(1)
                                    Text(song.artist ?? "Unknown Artist")
                                        .songFont()
                                        .foregroundColor(Color.white)
                                        .lineLimit(1)
                                }
                                Spacer()
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.bg)
                        }
                        .onDelete(perform: deleteSongFromShareView)
                    }
                    .listStyle(PlainListStyle())
                    
                    // MARK: - Save Button
                    Button {
                        saveSongsFromShareViewToRealm()
                    } label: {
                        HStack {
                            Text("Save")
                                .foregroundColor(.white)
                                .shuffleAndSortFont()
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity)
                                .background(Color.accent.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .padding(.bottom, 70)
                }
                .background(Color.bg)
                .onAppear {
                    extractData(size: size.size)
                }
            }
        }
    
    // MARK: - Methods
    
    /// Extracts Data From The File To Create A Song For App
    func extractData(size: CGSize) {
        
        guard items.isEmpty else { return }
        
        /// These operations are performed in the background so as not to block the main thread (UI thread) to keep the UI responsive.
        DispatchQueue.global(qos: .userInteractive).async {
            for provider in itemProviders {
                
                /// Get Audio Data
                let _ = provider.loadDataRepresentation(forTypeIdentifier: UTType.audio.identifier) { data, error in
                    if let data = data {
                        
                        /// Name, Artist, Cover, And Duration
                        let _ = provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) { item, error in
                            var songName = "Unknown Song"
                            var artist: String?
                            var coverData: Data?
                            var duration: TimeInterval?
                            
                            /// Extracting Metadata To Get Information
                            if let url = item as? URL {
                                if let asset = try? AVURLAsset(url: url) {
                                    for format in asset.availableMetadataFormats {
                                        for metadataItem in asset.metadata(forFormat: format) {
                                            
                                            /// Get Name And Artist
                                            if let commonKey = metadataItem.commonKey,
                                               let stringValue = metadataItem.value as? String {
                                                switch commonKey.rawValue {
                                                case "title":
                                                    songName = stringValue
                                                case "artist":
                                                    artist = stringValue
                                                default:
                                                    break
                                                }
                                            }
                                            
                                            /// Get  Image
                                            if let commonKey = metadataItem.commonKey,
                                               let imageData = metadataItem.value as? Data,
                                               commonKey.rawValue == "artwork" {
                                                coverData = imageData
                                            }
                                            
                                            /// Get Duration
                                            if let url = item as? URL {
                                                let asset = AVURLAsset(url: url)
                                                let durationInSeconds = CMTimeGetSeconds(asset.duration)
                                                duration = durationInSeconds
                                                print("Duration Value: \(durationInSeconds)")
                                            }
                                        }
                                    }
                                }
                            }
                            
                            /// Add Song To Array
                            DispatchQueue.main.async {
                                if !data.isEmpty {
                                    items.append(.init(name: songName, audioData: data, artist: artist, cover: coverData, duration: duration))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func saveSongsFromShareViewToRealm() {
        let config = appGroupRealmConfiguration()
        guard let fileURL = config.fileURL else {
            print("Error: Realm file URL not found.")
            return
        }

        
        do {
            let realm = try Realm(configuration: appGroupRealmConfiguration())
            
            try realm.write {
                for item in items {
                    let newSong = Song(name: item.name, data: item.audioData, artist: item.artist, coverImageData: item.cover, duration: item.duration)
                    realm.add(newSong)
                }
            }
            print("Songs successfully saved.")
            dismiss()
        } catch {
            print("Error when saving songs to Realm: \(error)")
        }
    }
    
    func dismiss() {
        extensionContext?.completeRequest(returningItems: [])
    }
    
    func deleteSongFromShareView(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
    
    // MARK: - Share Model
    private struct ShareSongModel: Identifiable {
        let id: UUID = .init()
        var name: String
        var audioData: Data
        var artist: String?
        var cover: Data?
        var duration: TimeInterval?
    }
}

// MARK: - Group Data Base Realm
func appGroupRealmConfiguration() -> Realm.Configuration {
    let appGroupIdentifier = "group.OMP"
    let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier)!
    let realmURL = sharedContainerURL.appendingPathComponent("SharedRealm.realm")
    return Realm.Configuration(fileURL: realmURL)
}
