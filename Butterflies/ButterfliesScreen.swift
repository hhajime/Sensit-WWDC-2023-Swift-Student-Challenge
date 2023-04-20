//
//  ButterfliesScreen.swift
//  Sensit
//
//  Created by Ha Jong Myeong on 2023/04/06.
//

import SwiftUI

struct ButterfliesScreen: View {
    @StateObject private var audioPlayer = AudioPlayer()
    @State private var showText = true
    private let soundFile = "002"
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Butterflies(screenSize: geometry.size)
                    .background(.black)
                VStack{
                    Spacer()
                    if showText {
                        Text("Sense it.")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation {
                            showText = false
                        }
                    }
                }
                Spacer()
                Spacer()
            }
            if showText {
                Text("🏳️‍🌈")
                    .font(.system(size: 40))
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    showText = false
                }
            }
        }
        .onAppear{audioPlayer.play(soundFile)}
        .onDisappear{audioPlayer.stop()}
    }
}
