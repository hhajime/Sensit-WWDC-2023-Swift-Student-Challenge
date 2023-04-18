//
//  SightGameScreen.swift
//  Butterfly
//
//  Created by Ha Jong Myeong on 2023/04/06.
//

import SwiftUI

struct SightGameScreen: View {
    @State private var scrollProgress: CGFloat = 0
    @StateObject private var audioPlayer = AudioPlayer()
    private let soundFile = "002"
    let backgroundImage = Image("003")
    var body: some View {
        ZStack{
            SpiderWebView()
            Butterflies()
        } .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(Animation.linear(duration: 300)) {
                    scrollProgress = 35
                }
            }
            .background(backgroundImage.resizable().ignoresSafeArea())
            .onAppear{audioPlayer.play(soundFile)}
            .onDisappear{audioPlayer.stop()}
    }
    
}
