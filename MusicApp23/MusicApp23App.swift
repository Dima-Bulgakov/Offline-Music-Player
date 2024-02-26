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
    @StateObject var rm = RealmManager(name: "realm")
    @StateObject var vm = ViewModel(realmManager: RealmManager(name: "viewModel"))
    @StateObject var importManager = ImportManager()
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ContainerView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
                .environmentObject(vm)
                .environmentObject(rm)
                .environmentObject(importManager)
                .environment(\.realmConfiguration, rm.appGroupRealmConfiguration())
            
                /// Device Information
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                    print("System Version: \(UIDevice.current.systemVersion)")
                    print("Device: \(UIDevice.current.modelName)")
                    print("Name: \(UIDevice.current.name)")
                    print("Display Name: \(Bundle.main.displayName)")
                    print("App Version: \(Bundle.main.appVersion)")
                    print("App Build: \(Bundle.main.appBuild)")
                    
                    /// Realm Database Address
                    if let realmFileURL = rm.realm?.configuration.fileURL {
                        print("Realm Database File URL: \(realmFileURL)")
                    } else {
                        print("Realm Database File URL: Not available")
                    }
                }
        }
    }
}
