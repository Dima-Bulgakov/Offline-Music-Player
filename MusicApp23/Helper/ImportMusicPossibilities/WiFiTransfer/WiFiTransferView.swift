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
//struct WiFiTransferView: View {
//    
//    // MARK: - Properties
//    @State private var webServer: GCDWebServer?
//    @State private var serverURL: String = ""
//    @EnvironmentObject var vm: ViewModel
//    @Environment (\.dismiss) private var dismiss
//    
//    // MARK: - Body
//    var body: some View {
//        VStack {
//            
//            // MARK: Header
//            HStack(alignment: .center) {
//                /// Title
//                Text("Wi-Fi Transfer")
//                    .tabBarFont()
//                    .frame(maxWidth: .infinity)
//                
//                /// Cancel Button
//                    .overlay(alignment: .topLeading) {
//                        Button {
//                            dismiss()
//                        } label: {
//                            Text("Cancel")
//                                .frame(width: 56)
//                                .foregroundColor(Color.accentColor)
//                        }
//                        .padding(.top, 8)
//                    }
//                    .padding()
//            }
//            
//            Spacer()
//            
//            /// Description
//            Text("Type this address into your browser")
//                .multilineTextAlignment(.center)
//                .foregroundColor(.white)
//                .padding(.horizontal)
//                .padding(.bottom, 5)
//            Image(systemName: "arrow.down")
//                .font(.title3)
//                .foregroundColor(.white)
//            
//            // MARK: IP Adress
//            ZStack {
//                Rectangle()
//                    .frame(width: 300, height: 70)
//                    .foregroundColor(Color.bg)
//                HStack {
//                    Text(serverURL)
//                        .foregroundColor(.blue)
//                        .font(.title2)
//                        .padding(.vertical, 20)
//                }
//                .frame(maxWidth: .infinity)
//            }
//
//            Text("Don't close the page to keep connection opened!")
//                .multilineTextAlignment(.center)
//                .padding(.horizontal)
//                .foregroundColor(.white)
//                .padding(.top)
//            
//            Spacer()
//            
//            // MARK: Open Connection Button
//            Button {
//                self.startServer()
//            } label: {
//                HStack {
//                    Text("Open Connection")
//                        .shuffleAndSortFont()
//                        .padding(.vertical, 15)
//                }
//                .frame(maxWidth: .infinity)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.accent, lineWidth: 1)
//                )
//            }
//            .frame(maxWidth: .infinity)
//            .padding(.bottom, 20)
//            .padding(.horizontal)
//        }
//        .background(Color.bunner)
//        
//        ///
//        .onDisappear {
//            /// Stop The Server When Closing WiFiTransferView
//            self.webServer?.stop()
//        }
//    }
//    
//    // MARK: - Methods
//    private func startServer() {
//        do {
//            guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//                print("Error: Unable to access the document directory.")
//                return
//            }
//            
//            let realm = try Realm(configuration: vm.appGroupRealmConfiguration())
//            
//            webServer = GCDWebServer()
//            
//            /// GET Request Handler
//            webServer?.addDefaultHandler(forMethod: "GET", request: GCDWebServerRequest.self, processBlock: { request in
//                /// HTML Form For File Upload
//                let html = HTMLPage.wifiTransferForm
//                return GCDWebServerDataResponse(html: html)
//            })
//            
//            /// POST Request Handler
//            webServer?.addHandler(forMethod: "POST", path: "/", request: GCDWebServerMultiPartFormRequest.self, processBlock: { request in
//                guard let files = (request as? GCDWebServerMultiPartFormRequest)?.files else {
//                    /// Error: Invalid Request
//                    return GCDWebServerDataResponse(statusCode: 400)
//                }
//                
//                for file in files {
//                    guard let fileURL = try? moveFileToDocumentDirectory(file: file) else {
//                        return GCDWebServerDataResponse(statusCode: 500)
//                    }
//                    
//                    do {
//                        // ... (остальной код)
//                    } catch {
//                        print("Failed to save song:", error)
//                        return GCDWebServerDataResponse(statusCode: 500)
//                    }
//                }
//                
//                return GCDWebServerDataResponse(html: HTMLPage.successMessage)
//            })
//            
//            /// Start The Server
//            try webServer?.start(options: [GCDWebServerOption_Port: 8081, GCDWebServerOption_BindToLocalhost: true])
//            if let serverURL = webServer?.serverURL?.absoluteString {
//                print("Local server running at \(serverURL)")
//                self.serverURL = serverURL
//            }
//            
//        } catch let error {
//            print("Ошибка при создании Realm или запуске сервера: \(error)")
//        }
//    }
//
//    private func moveFileToDocumentDirectory(file: GCDWebServerMultiPartFile) throws -> URL {
//        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
//            throw NSError(domain: "YourDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to access the document directory."])
//        }
//        
//        let uniqueFileName = "song_\(UUID().uuidString).mp3"
//        let fileURL = documentsURL.appendingPathComponent(uniqueFileName)
//        
//        try FileManager.default.copyItem(atPath: file.temporaryPath, toPath: fileURL.path)
//        
//        return fileURL
//    }
//    
//    private func getMetadata(from fileURL: URL, key: AVMetadataKey) -> Any? {
//        let asset = AVURLAsset(url: fileURL)
//        let metadata = asset.metadata(forFormat: .id3Metadata)
//        
//        return metadata.first { $0.commonKey == key }?.value
//    }
//
//}


//#Preview {
//    WiFiTransferView()
//}
