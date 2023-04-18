//
//  LandingView.swift
//  Sound & Sight Explorer
//
//  Created by Ha Jong Myeong on 2023/04/14.
//

import SwiftUI

struct LandingView: View {
    let backgroundImage = Image("002")
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Sound & Sight Explorer")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color.white)
            .padding()
            Spacer()
            NavigationLink(destination: GameScreen(composition: Composition(notes: defaultComposition))
                .background(backgroundImage.resizable().scaledToFill().ignoresSafeArea())) {
                    Text("Sound Explorer")
                        .font(.title3)
                        .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))
                
                .padding()
        }
        NavigationLink(destination: ButterflyView()) {
            Text("Sight Explorer")
                .font(.title3)
                .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))
        
        .padding()
    }
    Spacer()
}
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(backgroundImage.resizable().ignoresSafeArea())
}
    .navigationViewStyle(.stack)}
}
