//
//  LandingView.swift
//  Sound & Sight Explorer
//
//  Created by Ha Jong Myeong on 2023/04/14.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Sound & Sight \r\nExplorer")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding()
                Spacer()
                NavigationLink(destination: SoundGameScreen(composition: Composition(notes: defaultComposition))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Image("002").resizable().ignoresSafeArea())
                ) {
                    Text("Sound Explorer")
                        .font(.title3)
                        .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))
                    
                        .padding()
                }
                NavigationLink(destination: SightGameScreen()) {
                    Text("Sight Explorer")
                        .font(.title3)
                        .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))
                    
                        .padding()
                }
                Spacer()
                NavigationLink(destination: TutorialScreen()){
                    Text("Tutorial")
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 255/255, green: 255/255, blue: 102/255, opacity: 0.7), color2: Color(Color.RGBColorSpace.sRGB, red: 255/255, green: 255/255, blue: 0/255, opacity: 0.5), color3: Color(Color.RGBColorSpace.sRGB, red: 204/255, green: 204/255, blue: 0/255, opacity: 0.3))
                }
                Spacer()
                Text("* Wear earphones for a better experience")
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("001").resizable().ignoresSafeArea())
        }
        .navigationViewStyle(.stack)}
}
