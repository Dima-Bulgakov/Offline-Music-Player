//
//  PlayerView.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//

import SwiftUI

struct PlayerView: View {
    
    // MARK: - Properties
    @EnvironmentObject var vm: ViewModel
    @State private var isShowSongMenu = false
    
    // MARK: - Body
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: - Time
            HStack {
                Text("\(vm.durationFormatted(vm.currentTime))")
                    .timeFont()
                Spacer(minLength: 0)
                
                Text("\(vm.durationFormatted(vm.totalTime))")
                    .timeFont()
            }
            .padding(.horizontal, 8)
            
            // MARK: - Timeline
            Slider(value: Binding(get: {
                vm.currentTime
            }, set: { newValue in
                vm.seekAudio(to: newValue)
            }), in: 0...vm.totalTime)
            .foregroundColor(.white)
            .zIndex(1)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    vm.updateProgress()
                }
            }
            
            VStack(spacing: 10) {
                
                // MARK: - Menu
                Button {
                    self.isShowSongMenu.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color.white)
                }
                .padding(.top)
                .popover(isPresented: $isShowSongMenu, attachmentAnchor: .point(.bottom), arrowEdge: .bottom, content: {
                    SongMenu()
                })
                
                // MARK: - Description
                HStack {
                    if let currentSong = vm.currentSong {
                        HStack {
                            Text(currentSong.artist ?? "")
                                .artistFont()
                            Text("-")
                            Text(currentSong.name)
                                .songFont()
                        }
                    } else {
                        Text("-")
                    }
                }
                .padding(.bottom, 10)
                
                // MARK: Buttons
                HStack {
                    Spacer()
                    CustomPlayerButton(image: "repeat", size: 18, color: vm.isRepeat ? Color.gray : Color.primaryFont) {
                        vm.toggleRepeat()
                    }
                    Spacer()
                    CustomPlayerButton(image: "backward", size: 24, color: Color.primaryFont) {
                        vm.backward()
                    }
                    Spacer()
                    PlayPauseButton()
                    Spacer()
                    CustomPlayerButton(image: "forward", size: 24, color: Color.primaryFont) {
                        vm.forward()
                    }
                    Spacer()
                    CustomPlayerButton(image: "shuffle", size: 18, color: vm.isShuffle ? Color.gray : Color.primaryFont) {
                        vm.shuffleSongs()
                    }
                    Spacer()
                }
                .font(.largeTitle)
            }
            .foregroundColor(Color.primary)
            .padding(.vertical, 5)
            .background(Color.bg)
            .offset(y: -18)
        }
        .frame(maxWidth: .infinity)
        .shadow(color: .black.opacity(0.6), radius: 20, y: 0)
        .shadow(color: .black, radius: 30, y: 0)
        .offset(y: -4)
    }
}

#Preview {
    ZStack {
        Color.white
        ContentView()
            .environmentObject(ViewModel())
            .environmentObject(VMImportManager())
            .preferredColorScheme(.dark)
    }
}


