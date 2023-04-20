//
//  ButterfliesScreen.swift
//  Sensia
//
//  Created by Ha Jong Myeong on 2023/04/06.
//

import SwiftUI

struct ButterfliesScreen: View {
    @StateObject private var audioPlayer = AudioPlayer()
    private let soundFile = "002"
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Butterflies(screenSize: geometry.size)
                    .background(.black)
                Text("🏳️‍🌈")
                    .font(.system(size: 40))
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
            .onAppear{audioPlayer.play(soundFile)}
            .onDisappear{audioPlayer.stop()}
        }
    }
}
