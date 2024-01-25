//
//  ImportManager.swift
//  MusicApp23
//
//  Created by Dima on 19.01.2024.
//

import SwiftUI

final class VMImportManager: ObservableObject {
    
    // MARK: - Properties    
    @Published var isPhotoPickerPresented = false
    @Published var actionSheetVisible = false
    @Published var selectedDocument: Data?
    @Published var selectedDocumentName: String?
    @Published var isFilesPresented = false
}
