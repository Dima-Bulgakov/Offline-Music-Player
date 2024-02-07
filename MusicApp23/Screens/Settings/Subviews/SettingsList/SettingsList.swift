//
//  SettingsList.swift
//  MusicApp23
//
//  Created by Dima on 22.12.2023.
//

import SwiftUI

struct SettingsList: View {
    
    // MARK: - Model
    struct SettingItem: Identifiable {
        let id = UUID()
        let image: String
        let title: String
        let action: () -> ()
    }
    
    // MARK: - Property
    @State private var isShowingEmailSheet = false // Переменная состояния для управления отображением Sheet
    
    var settingsArray: [SettingItem] {
        [
            SettingItem(image: "report", title: "Report Bug") {
                isShowingEmailSheet.toggle()
            },
            SettingItem(image: "rate", title: "Rate Us") {
                
            },
            SettingItem(image: "share", title: "Share App") {
                // Действие для нажатия на "Share App"
            },
            SettingItem(image: "privacy", title: "Privacy Policy") {
                // Действие для нажатия на "Privacy Policy"
            },
            SettingItem(image: "terms", title: "Terms of Use") {
                // Действие для нажатия на "Terms of Use"
            }
        ]
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            List {
                ForEach(settingsArray) { item in
                    SettingListCell(image: item.image, title: item.title, action: item.action)
                        .listRowBackground(Color.bg)
                }
            }
            .listStyle(.plain)
            .frame(height: 330)
            .sheet(isPresented: $isShowingEmailSheet) {
                EmailComposeSheet(isPresented: $isShowingEmailSheet)
            }
        }
    }
}

import MessageUI

struct EmailComposeSheet: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = context.coordinator
        mailComposer.setToRecipients(["voiosupport@gmail.com"])
        mailComposer.setSubject("Report Bug")
        mailComposer.setMessageBody("Tell us about an issue:", isHTML: false)
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {
        // Update UI if needed
    }
}


#Preview {
    SettingsList()
        .preferredColorScheme(.dark)
}
