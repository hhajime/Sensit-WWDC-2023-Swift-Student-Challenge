//
//  CircularNoteView.swift
//  Sensit
//
//  Created by Ha Jong Myeong on 2023/04/13.
//
import SwiftUI
import Combine

struct CircularNoteView: View {
    @State private var noteRadius: CGFloat = 500
    @State private var noteOpacity: Double = 1
    @State private var remainingTime: TimeInterval = 0
    @State private var isPaused: Bool = false
    @Binding var innerCircleScale: CGFloat
    @Binding var touchStatus: String
    @Binding var isPlaying: Bool

    let note: Note
    let onDestroyed: () -> Void
    
    var body: some View {
            Circle()
                .frame(width: noteRadius, height: noteRadius)
                .opacity(noteOpacity)
                .overlay(
                    Circle()
                        .stroke(Color(.white), lineWidth: 10)
                        .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))
                )
                .onAppear {
                    startAnimationIfNeeded()
                }
        }
    
    private func startNoteAnimation() {
//        print("note start")
        withAnimation(.linear(duration: 0.8)) {
            noteRadius = innerCircleScale
            noteOpacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            onDestroyed()
        }
    }

    
    private func pauseNoteAnimation() {
        isPaused = true
        noteRadius = 80
        noteOpacity = 0
    }
    
    private func startAnimationIfNeeded() {
        if isPlaying {
            startNoteAnimation()
        }
    }
}
