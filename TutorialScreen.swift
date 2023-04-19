//
//  TutorialScreen.swift
//  Sound & Sight Explorer
//
//  Created by Ha Jong Myeong on 2023/04/19.
//

import SwiftUI

struct TutorialScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Sound Explorer")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                tutorialStep(text: "1. Observe a circular audio visualizer with circular notes appearing around it.")
                
                tutorialStep(text: "2. Feel the beat and touch the notes when they align with the speaker in the center.")
                
                tutorialStep(text: "3. If you tap the note at the right time, you will see a 'perfect' or 'good' touch status.")
                
                tutorialStep(text: "4. Keep an eye on the number of consecutive times you successfully tap the note.")
                
                Text("Sight Explorer")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)
                
                tutorialStep(text: "1. Watch a butterfly appear on the screen.")
                
                tutorialStep(text: "2. Listen to the soothing background music that starts to play automatically.")
                
                tutorialStep(text: "3. Drag the butterfly dynamically with the music.")
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("For both games, you should feel the music.")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top)

                    Text("It's okay to get it wrong!")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top)

                    Text("I just want you to feel the music, interact with the beautiful screens, and have fun!")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(.top)
                }
            }
            .padding()
        }
        .background(Color.black)
    }
    
    private func tutorialStep(text: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(text)
                .font(.body)
                .foregroundColor(.white)
        }
    }
}

struct TutorialScreen_Previews: PreviewProvider {
    static var previews: some View {
        TutorialScreen()
    }
}
