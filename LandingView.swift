//
//  LandingView.swift
//  Sensit
//
//  Created by Ha Jong Myeong on 2023/04/14.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Sensit.")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .foregroundColor(Color.white)
                    .padding()
                Spacer()
                NavigationLink(destination: SoundGameScreen(composition: Composition(notes: defaultComposition))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Image("002").resizable().ignoresSafeArea())
                    .background(.black)
                ) {
                    Text("Sense with Vibe-in")
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding()
                }
                NavigationLink(destination: ButterfliesScreen()) {
                    Text("Sense with Butterflies")
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding()
                }
                Spacer()
                NavigationLink(destination: TutorialScreen()){
                    Text("Tutorials")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                Spacer()
                Text("earphones recommended")
                    .foregroundColor(.white)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("001").resizable().ignoresSafeArea())
        }
        .navigationViewStyle(.stack)}
}
