//
//  TutorialScreen.swift
//  Sensia
//
//  Created by Ha Jong Myeong on 2023/04/19.
//

import SwiftUI

struct TutorialScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Vibe-in")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                tutorialStep(text: "1. Observe a circular audio visualizer with circular notes appearing around it.")
                
                tutorialStep(text: "2. Feel the beat and touch the notes when they align with the speaker in the center.")
                
                tutorialStep(text: "3. If you tap the note at the right time, you will see a 'perfect' or 'good' touch status.")
                
                tutorialStep(text: "4. Keep an eye on the number of consecutive times you successfully tap the note.")
                
                Text("Butterflies")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top)
                
                tutorialStep(text: "1. Observe the butterfly symbolizing the LGBTQ+ community or society appear on the screen.")

                tutorialStep(text: "2. Immerse yourself as soothing background music begins to play, setting the tone for an inclusive and expressive experience.")

                tutorialStep(text: "3. Interact with the LGBTQ+ themed butterfly colony as they gracefully move to the music for a unique experience. When they are set free, they show their true colors.")
                
                VStack(alignment: .leading, spacing: 8) {
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
