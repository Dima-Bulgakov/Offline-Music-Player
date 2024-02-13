//
//  MusicApp23App.swift
//  MusicApp23
//
//  Created by Dima on 19.12.2023.
//

import SwiftUI

@main
struct MusicApp23App: App {
    
    // MARK: - Properties
    @AppStorage("isDarkMode") private var isDarkMode = true
    @StateObject var vm = ViewModel()
    @StateObject var importManager = VMImportManager()
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
//            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
//            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContainerView()
//            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environmentObject(vm)
                .environmentObject(importManager)
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    print("System Version: \(UIDevice.current.systemVersion)")
                    print("Device: \(UIDevice.current.modelName)")
                    print("Name: \(UIDevice.current.name)")
                    print("Display Name: \(Bundle.main.displayName)")
                    print("App Version: \(Bundle.main.appVersion)")
                    print("App Build: \(Bundle.main.appBuild)")
                }
        }
    }
}
