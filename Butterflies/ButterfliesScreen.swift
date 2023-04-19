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
        ZStack{
            Butterflies()
                .background(.black)
        }
        .onAppear{audioPlayer.play(soundFile)}
        .onDisappear{audioPlayer.stop()}
    }
    
}
