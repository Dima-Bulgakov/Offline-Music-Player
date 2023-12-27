//
//  Possibilities.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct Possibilities: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    struct Possibility: Hashable, Identifiable {
        let id = UUID()
        var imageName: String
    }
    
    let possibilities: [Possibility] = [
        Possibility(imageName: "files"),
        Possibility(imageName: "wifi"),
        Possibility(imageName: "pcImport"),
        Possibility(imageName: "bySharing"),
        Possibility(imageName: "camera"),
        Possibility(imageName: "safari")
    ]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                
                // MARK: - Title
                Text("Add Music")
                    .titleFont()
                Spacer()
                
                // MARK: - All Possibilities Button
                NavigationLink(destination: WelcomeView()) {
                    Text("All Possibilities")
                        .blueButtonFont()
                }
            }
            .padding(.horizontal)
            
            // MARK: - Possibilities
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    
                    ForEach(possibilities, id: \.self) { item in
                        Button(action: {
                            switch item.imageName {
                            case "files":
                                vm.isFilePresented.toggle()
                            default:
                                break
                            }
                        }, label: {
                            Image(item.imageName)
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(Color.accent)
                                .padding(10)
                                .padding(.horizontal, 12)
                                .background(Color.white)
                                .cornerRadius(22)
                                .frame(height: 36)
                        })
                    }
                }
                .padding(.trailing, 26)
                .offset(x: 16)
            }
        }
        .padding(.top, 20)
        
        // MARK: - Files Open
        .sheet(isPresented: self.$vm.isFilePresented) {
            ImportFileManager(songs: $vm.songs, file: $vm.selectedDocument, fileName: $vm.selectedDocumentName, vm: vm)
        }
        .confirmationDialog("Выберите тип", isPresented: $vm.actionSheetVisible) {
            Button("MP3 файл") {
                vm.selectedDocument = nil
                vm.selectedDocumentName = nil
                vm.isFilePresented.toggle()
            }
        }
    }
}

#Preview {
    Possibilities()
        .environmentObject(ViewModel())
        .preferredColorScheme(.dark)
}
