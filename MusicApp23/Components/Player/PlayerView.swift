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
    @State private var isDraggingSlider = false
    
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
            Slider(value: $vm.currentTime, in: 0...vm.totalTime) { editing in
                isDraggingSlider = editing
                if !editing {
                    vm.seekAudio(to: vm.currentTime)
                    
                }
            }
            .accentColor(Color.accent)
            .zIndex(1)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    vm.updateProgress()
                }
            }
            
            VStack(spacing: 10) {
                
                // MARK: - Song Menu
                Button {
                    if let currentSong = vm.currentSong {
                        vm.isShowSongMenu.toggle()
                        vm.isMenuVisible = false
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundStyle(Color.white)
                        .padding(5)
                        .padding(.top)
                }
                .popover(isPresented: $vm.isShowSongMenu, attachmentAnchor: .point(.bottom), arrowEdge: .bottom, content: {
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
                .padding(.bottom, 8)
                
                // MARK: Player Buttons
                HStack {
                    Spacer()
                    CustomPlayerButton(image: "repeat", size: 18, color: vm.isRepeatModeEnabled ? Color.white.opacity(0.5) : Color.white) {
                        vm.repeatSong()
                        vm.isMenuVisible = false
                    }
                    Spacer()
                    CustomPlayerButton(image: "backward", size: 24, color: Color.primaryFont) {
                        vm.backward()
                        vm.isMenuVisible = false
                    }
                    Spacer()
                    PlayPauseButton()
                    Spacer()
                    CustomPlayerButton(image: "forward", size: 24, color: Color.primaryFont) {
                        vm.forward()
                        vm.isMenuVisible = false
                    }
                    Spacer()
                    CustomPlayerButton(image: "shuffle", size: 18, color: vm.isShuffleModeEnabled ? Color.white.opacity(0.5) : Color.white) {
                        vm.isShuffleModeEnabled.toggle()
                        vm.isMenuVisible = false
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


// MARK: - Preview
#Preview {
    ZStack {
        Color.white
        ContentView()
            .environmentObject(ViewModel(realmManager: RealmManager(name: "realm")))
            .environmentObject(RealmManager(name: "viewModel"))
            .preferredColorScheme(.dark)
    }
}
