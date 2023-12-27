//
//  Font+Extension.swift
//  MusicApp23
//
//  Created by Dima on 21.12.2023.
//


import SwiftUI

// MARK: - Fonts Extension
extension Text {
    func tabBarFont() -> some View {
        self
            .foregroundStyle(Color.primaryFont)
            .font(.custom("SFProDisplay-Regular", size: 19))
            .lineLimit(1)
            .padding(.top, 5)
    }
    
    func titleFont() -> some View {
        self
            .foregroundStyle(Color.primaryFont)
            .font(.custom("SFProDisplay-Regular", size: 22))
            .lineLimit(1)
            .padding(.bottom, 5)
    }
    
    func blueButtonFont() -> some View {
        self
            .foregroundStyle(Color.accent)
            .font(.custom("SFProRounded-Regular", size: 14))
    }
    
    func nameFont() -> some View {
        self
            .foregroundStyle(Color.primaryFont)
            .font(.custom("SFProText-Regular", size: 16))
    }
    
    func descriptionFont() -> some View {
        self
            .foregroundStyle(Color.secondaryFont)
            .font(.custom("SFProText-Regular", size: 14))
    }
    
    func searchFont() -> some View {
        self
            .underline(true, color: Color.secondaryFont)
            .foregroundStyle(Color.secondaryFont)
            .font(.custom("SFProText-Regular", size: 16))
    }
    
    func playlistButtonsFont() -> some View {
        self
            .font(.system(size: 16))
            .bold()
    }
    
    func shuffleAndSortFont() -> some View {
        self
            .foregroundStyle(Color.secondaryFont)
            .font(.custom("SFProText-Regular", size: 17))
            .lineSpacing(22)
    }
    
    func artistFont() -> some View {
        self
            .font(.system(size: 14))
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
    }
    
    func songFont() -> some View {
        self
            .font(.system(size: 14))
            .fontWeight(.light)
            .multilineTextAlignment(.center)
    }
    
    func getBunnerFont() -> some View {
        self
            .font(.system(size: 19, weight: .semibold))
            .foregroundStyle(Color.primaryFont)
            .multilineTextAlignment(.center)
    }
    
    func importLinkFont() -> some View {
        self
            .underline(true, color: Color.accentColor)
            .foregroundStyle(Color.accent)
            .font(.custom("SFProRounded-Regular", size: 15))
            
    }
    
    func importButtonFont() -> some View {
        self
            .foregroundStyle(Color.primaryFont)
            .font(.custom("SFProRounded-Regular", size: 15))
    }
    
    func timeFont() -> some View {
        self
            .foregroundStyle(Color.primaryFont)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    
    func menuFont() -> some View {
        self
            .font(.system(size: 16, weight: .regular))
            .foregroundStyle(Color.bg)
            .multilineTextAlignment(.center)
    }
    
    func selectedMenuFont() -> some View {
        self
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(Color.accent)
            .multilineTextAlignment(.center)
    }
    
    func songMenuFont() -> some View {
        self
            .foregroundStyle(Color.secondaryFont)
            .font(.custom("SFProText-Regular", size: 16))
            .lineSpacing(22)
    }
}

struct FontsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("TabBar Font").tabBarFont()
            Text("Title Font").titleFont()
            Text("Blue Button Font").blueButtonFont()
            Text("Name Font").nameFont()
            Text("Description Font").descriptionFont()
            Text("Search Font").searchFont()
            Text("Playlist Buttons Font").playlistButtonsFont()
            Text("Shuffle And Sort Font").shuffleAndSortFont()
            Text("Artist Font").artistFont()
            Text("Song Font").songFont()
            Text("Get Pro Bunner").getBunnerFont()
            Text("Import Link Font").importLinkFont()
            Text("Import Button Font").importButtonFont()
            Text("Time Font").timeFont()
            Text("songMenuFont").songMenuFont()
            VStack {
                Text("Menu Font").menuFont()
                Text("Menu Font").selectedMenuFont()
            }
            .padding()
            .background(.white)
        }
        .padding()
    }
}

struct FontsView_Previews: PreviewProvider {
    static var previews: some View {
        FontsView()
            .preferredColorScheme(.dark)
    }
}
