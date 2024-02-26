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


// MARK: - Wi-fi Transfer Importing Music
struct WiFiTransferView: View {
    
    // MARK: - Properties
    @State private var webServer: GCDWebServer?
    @State private var serverURL: String = ""
    @EnvironmentObject var vm: ViewModel
    @EnvironmentObject var importManager: VMImportManager
    @Environment (\.dismiss) private var dismiss
    @State private var netService: NetService?
    
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
        .background(Color.bunner)
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
            webServer?.addHandler(forMethod: "POST", path: "/", request: GCDWebServerMultiPartFormRequest.self, processBlock: { request in
                if let files = (request as? GCDWebServerMultiPartFormRequest)?.files {
                    
                    for file in files {
                        let uniqueFileName = "song_\(Date().timeIntervalSince1970).mp3"
                        let fileURL = documentsURL.appendingPathComponent(uniqueFileName)
                        
                        do {
                            /// Copy The Temporary File To The Document Directory
                            try FileManager.default.copyItem(atPath: file.temporaryPath, toPath: fileURL.path)
                            
                            /// Get Song Metadata
                            let trackName = self.getMetadata(from: fileURL, key: .commonKeyTitle) as? String ?? "Unknown Track"
                            let artist = self.getMetadata(from: fileURL, key: .commonKeyArtist) as? String ?? "Unknown Artist"
                            let coverData = self.getMetadata(from: fileURL, key: .commonKeyArtwork) as? Data
                            let asset = AVURLAsset(url: fileURL)
                            let duration = asset.duration.seconds
                            
                            /// Convert The File Path To Data
                            if let fileData = FileManager.default.contents(atPath: fileURL.path) {
                                /// Save Song Metadata To Realm
                                DispatchQueue.main.async {
                                    vm.addSong(name: trackName, data: fileData, artist: artist, coverImageData: coverData, duration: duration)
                                }
                            } else {
                                print("Failed to convert file to Data.")
                                return GCDWebServerDataResponse(statusCode: 500)
                            }
                        } catch {
                            print("Failed to save song:", error)
                            return GCDWebServerDataResponse(statusCode: 500)
                        }
                    }
                    
                    return GCDWebServerDataResponse(html: HTMLPage.successMessage)
                } else {
                    return GCDWebServerDataResponse(html: HTMLPage.errorMessage)
                }
            })
            
            /// Start The Server
            try webServer?.start(options: [GCDWebServerOption_Port: 8081, GCDWebServerOption_BindToLocalhost: false])
                    if let serverURL = webServer?.serverURL?.absoluteString {
                        print("Local server running at \(serverURL)")
                        DispatchQueue.main.async {
                            // Обновляем serverURL на правильный IP-адрес
                            self.serverURL = serverURL
                        }
                    } else {
                        // Если webServer.serverURL недоступен, пытаемся использовать getWiFiAddress()
                        if let ipAddress = self.getWiFiAddress() {
                            let correctURL = "http://\(ipAddress):8081"
                            DispatchQueue.main.async {
                                self.serverURL = correctURL
                                print("Fallback Server IP Address: \(ipAddress)")
                            }
                        }
                    }
            
        } catch let error {
            print("Ошибка при создании Realm или запуске сервера: \(error)")
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
    private func getMetadata(from fileURL: URL, key: AVMetadataKey) -> Any? {
        let asset = AVURLAsset(url: fileURL)
        let metadata = asset.metadata(forFormat: .id3Metadata)
        
        return metadata.first { $0.commonKey == key }?.value
    }
    
    // MARK: Method Is Used To Get The IP Of A Device On The Local Network Through The Wi-Fi
    private func getWiFiAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        /// Get The List Of Interfaces
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        for ptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let flags = Int32(ptr.pointee.ifa_flags)
            let addr = ptr.pointee.ifa_addr.pointee
            
            /// Verify That It Is A Wi-Fi Interface And Has An IP Address
            if (flags & (IFF_UP | IFF_RUNNING | IFF_LOOPBACK)) == (IFF_UP | IFF_RUNNING),
               addr.sa_family == UInt8(AF_INET) {
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                if (getnameinfo(ptr.pointee.ifa_addr, socklen_t(addr.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                    address = String(cString: hostname)
                    break
                }
            }
        }
        freeifaddrs(ifaddr)
        return address
    }
}


#Preview {
    WiFiTransferView()
}
