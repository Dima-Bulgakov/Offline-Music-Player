//
//  WiFiTransferView.swift
//  MusicApp23
//
//  Created by Dima on 12.02.2024.
//

import SwiftUI
import GCDWebServer
import RealmSwift
import AVFoundation


// MARK: - Importing Music Through Wifi Transfer
struct WiFiTransferView: View {
    
    // MARK: - Properties
    @EnvironmentObject var rm: RealmManager
    @Environment (\.dismiss) private var dismiss
    
    @State private var webServer: GCDWebServer?
    @State private var serverURL: String = ""
    @State private var netService: NetService?
    @State var serverIPAddress: String?
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            /// Header
            HeaderViewWiFiTransfer(title: "Wi-Fi Transfer", dismiss: dismiss)
            
            Spacer()
            
            /// Description
            DescriptionViewWiFiTransfer(serverURL: $serverURL)
            
            Spacer()
            
            /// Open Connection Button
            OpenConnectionButtonWiFiTransfer(serverURL: $serverURL, startServer: startServer)
                .padding(.bottom, 20)
            
        }
        .background(Color.bg)
        .onDisappear {
            stopServer()
        }
    }
    
    // MARK: - Methods
    private func startServer() {
        do {
            guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                print("Error: Unable to access the document directory.")
                return
            }
            
            webServer = GCDWebServer()
            
            /// NetService To Announce The Service
            netService = NetService(domain: "local.", type: "_http._tcp.", name: "MyServer", port: 8081)
            netService?.publish()
            
            /// GET Request Handler
            webServer?.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: { request in
                /// HTML Form For File Upload
                let html = HTMLPage.wifiTransferForm
                return GCDWebServerDataResponse(html: html)
            })
            
            /// POST Request Handler
            webServer?.addHandler(forMethod: "POST", path: "/", request: GCDWebServerMultiPartFormRequest.self, asyncProcessBlock: { request, completionBlock in
                guard let multiPartRequest = request as? GCDWebServerMultiPartFormRequest else {
                    completionBlock(GCDWebServerDataResponse(statusCode: 400))
                    return
                }
                
                let files = multiPartRequest.files as! [GCDWebServerMultiPartFile]
                var savedSongs: [Song] = []
                
                do {
                    let realmConfiguration = self.rm.appGroupRealmConfiguration()
                    let realm = try Realm(configuration: realmConfiguration)
                    
                    for file in files {
                        let fileURL = try self.moveFileToDocumentDirectory(file: file)
                        let asset = AVURLAsset(url: fileURL)
                        
                        let trackName = self.getMetadata(from: asset, key: .commonKeyTitle) as? String ?? "Unknown Track"
                        let artist = self.getMetadata(from: asset, key: .commonKeyArtist) as? String ?? "Unknown Artist"
                        let coverData = self.getMetadata(from: asset, key: .commonKeyArtwork) as? Data
                        let duration = asset.duration.seconds
                        
                        if let fileData = FileManager.default.contents(atPath: fileURL.path) {
                            // Проверка на существование песни
                            let existingSong = realm.objects(Song.self).filter("name == %@ AND artist == %@ AND duration == %@", trackName, artist, duration).first
                            if existingSong == nil {
                                let newSong = Song(name: trackName, data: fileData, artist: artist, coverImageData: coverData, duration: duration)
                                savedSongs.append(newSong)
                            } else {
                                print("Song already exists and won't be added again: \(trackName)")
                            }
                        } else {
                            print("Failed to convert file to Data.")
                            continue
                        }
                    }
                } catch {
                    print("Error initializing Realm or processing files: \(error)")
                    completionBlock(GCDWebServerDataResponse(statusCode: 500))
                    return
                }
                
                /// Save All Songs To Realm After Processing All Files
                DispatchQueue.main.async {
                    do {
                        let realm = try Realm(configuration: self.rm.appGroupRealmConfiguration())
                        try realm.write {
                            for song in savedSongs {
                                realm.add(song)
                            }
                        }
                        completionBlock(GCDWebServerDataResponse(html: HTMLPage.successMessage))
                    } catch {
                        print("Error saving songs to Realm:", error)
                        completionBlock(GCDWebServerDataResponse(statusCode: 500))
                    }
                }
            })
            
            /// Start The Server
            try webServer?.start(options: [GCDWebServerOption_Port: 8081, GCDWebServerOption_BindToLocalhost: false])
            updateServerAddress()
            
        } catch let error {
            print("Ошибка при создании Realm или запуске сервера: \(error)")
        }
        
    }
    
    private func updateServerAddress() {
        DispatchQueue.main.async {
            if let ipAddress = self.getWiFiAddress() {
                self.serverURL = "http://\(ipAddress):8081"
                print("Local server running at \(self.serverURL)")
                self.serverIPAddress = ipAddress
            } else {
                print("Unable to retrieve Wi-Fi IP address")
            }
        }
    }
    
    // MARK: Method Stops The NetService To Stop Declaring The Service.
    private func stopServer() {
        DispatchQueue.global(qos: .background).async {
            self.webServer?.stop()
        }
    }
    
    // MARK: Returns the URL where the file was saved.
    private func moveFileToDocumentDirectory(file: GCDWebServerMultiPartFile) throws -> URL {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to access the document directory."])
        }
        
        let uniqueFileName = "song_\(UUID().uuidString).mp3"
        let fileURL = documentsURL.appendingPathComponent(uniqueFileName)
        
        try FileManager.default.copyItem(atPath: file.temporaryPath, toPath: fileURL.path)
        
        return fileURL
    }
    
    // MARK: Method For Extracting Song Metadata
    private func getMetadata(from asset: AVURLAsset, key: AVMetadataKey) -> Any? {
        let metadata = asset.commonMetadata
        return metadata.first { $0.commonKey == key }?.value
    }
    
    // MARK: Method Is Used To Get The IP Of A Device On The Local Network Through The Wi-Fi
    private func getWiFiAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { continue }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET), // Фильтр для IPv4
                   interface.ifa_flags & UInt32(IFF_UP) != 0 {
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    if getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                   &hostname, socklen_t(hostname.count),
                                   nil, socklen_t(0), NI_NUMERICHOST) == 0,
                       let name = interface.ifa_name, String(cString: name) == "en0" {
                        address = String(cString: hostname)
                        break
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
}


// MARK: - Preview
#Preview {
    WiFiTransferView()
}
