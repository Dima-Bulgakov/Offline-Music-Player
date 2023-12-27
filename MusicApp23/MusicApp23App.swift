//
//  MusicApp23App.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//

import SwiftUI

@main
struct MusicApp23App: App {
    @AppStorage("isDarkMode") private var isDarkMode = true
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environmentObject(vm)
        }
    }
}
