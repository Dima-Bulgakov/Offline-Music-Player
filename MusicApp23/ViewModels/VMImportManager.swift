//
//  ImportManager.swift
//  MusicApp23
//
//  Created by Dima on 19.01.2024.
//

import SwiftUI

// MARK: - Import`s Properties
final class VMImportManager: ObservableObject {
    
    @Published var isPhotoPickerPresented = false
    @Published var isFilesPresented = false
    
    @Published var selectedDocumentName: String?
    @Published var selectedDocument: Data?
    
    @Published var isShowShareAlert = false
    @Published var isShowSafariAlert = false
    
    @Published var isShowWiFiTransferSheet = false
}
