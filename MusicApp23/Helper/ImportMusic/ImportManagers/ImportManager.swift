//
//  ImportManager.swift
//  MusicApp23
//
//  Created by Dima on 25.02.2024.
//

import Foundation


// MARK: - Import`s Properties
final class ImportManager: ObservableObject {
    
    @Published var isPhotoPickerPresented = false
    @Published var isFilesPresented = false
    
    @Published var selectedDocumentName: String?
    @Published var selectedDocument: Data?
    
    @Published var isShowShareAlert = false
    @Published var isShowSafariAlert = false
    
    @Published var isShowWiFiTransferSheet = false
    @Published var serverIPAddress: String?

}
