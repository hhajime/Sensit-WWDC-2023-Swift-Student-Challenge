//
//  SoundGameScreen.swift
//  Sensia
//
//  Created by Ha Jong Myeong on 2023/04/12.
//

import SwiftUI

struct SoundGameScreen: View {
    @State private var currentTime: Double = 0
    
    @State var composition: Composition
    @State private var score: Int = 0
    @State private var isPlayingAudio = false
    @State private var touchStatus: String = ""
    @State private var streakCount: Int = 0
    @State private var activeNotes: Set<UUID> = []
    @State private var wooferScale: CGFloat = 1.0
    @State private var activeNotesList: [Note] = []
    
    private let audioProcessor = AudioProcessor.sharedInstance
    
    var body: some View {
        ZStack{
            VStack{
                //                playbackControls
                touchStats
                //                noteAndMusicTimes
                Spacer()
            }
            VStack {
                CircularAudioVisualizer(isPlayingAudio: $isPlayingAudio, touchStatus: $touchStatus, streakCount: $streakCount, activeNotes: $activeNotes, composition: composition, currentTime: currentTime)
            }.onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
                if isPlayingAudio {
                    currentTime = currentMusicTime()
                }
            })
            circularNoteView
        }
        .preferredColorScheme(.dark)
        .onAppear(perform: {
//            print("d")
            isPlayingAudio = true
            audioProcessor.setupAudioEngine()
            audioProcessor.audioPlayerNode?.play()
            scheduleNotes()
        })
        .onDisappear {
            score = 0
            isPlayingAudio = false
            touchStatus = ""
            streakCount = 0
            activeNotes = []
            wooferScale = 1.0
            activeNotesList = []
            audioProcessor.audioPlayerNode?.stop()
        }
    }
    
    private var noteAndMusicTimes: some View {
        VStack {
            Text("Note time: \(activeNotes.first.flatMap { noteTime(forNoteWithID: $0) } ?? 0)")
                .font(.caption)
                .foregroundColor(.white)
            Text("Music time: \(currentTime)")
                .font(.caption)
                .foregroundColor(.white)
        }
    }
    
    private func noteTime(forNoteWithID id: UUID) -> Double? {
        defaultComposition.first(where: { $0.id == id })?.startTime
    }
    
    private func currentMusicTime() -> Double {
        guard let playerNodeTime = audioProcessor.audioPlayerNode?.playerTime(
            forNodeTime: (audioProcessor.audioPlayerNode?.lastRenderTime!)!
        ) else { return 0 }
        return Double(playerNodeTime.sampleTime) / playerNodeTime.sampleRate
    }
    
    private func scheduleNotes() {
        guard let playerNodeTime = audioProcessor.audioPlayerNode?.playerTime(
            forNodeTime: (audioProcessor.audioPlayerNode?.lastRenderTime!)!
        ) else { return }
        
        let currentTime = Double(playerNodeTime.sampleTime) / playerNodeTime.sampleRate
        let musicStartTime = isPlayingAudio ? currentTime : 0
        
        for note in defaultComposition {
            let timeDifference = note.startTime - musicStartTime
            if timeDifference > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + timeDifference) {
                    if isPlayingAudio {
                        activeNotes.insert(note.id)
                    }
                }
            }
        }
    }
    
    private var circularNoteView: some View {
        ZStack{
            ForEach(defaultComposition) { note in
                if activeNotes.contains(note.id) {
                    CircularNoteView(innerCircleScale: $wooferScale, touchStatus: $touchStatus, isPlaying: $isPlayingAudio, note: note) {
                        activeNotes.remove(note.id)
                    }
                }
            }
        }
    }
    
    private var playbackControls: some View {
        Button(action: audioPlaybackButtonTapped) {
            Image(systemName: "\(isPlayingAudio ? "pause" : "play")")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .foregroundColor(.secondary)
    }
    
    private var touchStats: some View {
        VStack{
            Text(touchStatus)
                .font(.system(size: 40, weight: .bold))
                .addGlowEffect(
                    color1: glowColor(for: touchStatus).0,
                    color2: glowColor(for: touchStatus).1,
                    color3: glowColor(for: touchStatus).2
                )
            Text("\(streakCount)/\(defaultComposition.count)")
                .font(.largeTitle)
            .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))    }
    }
    
    private func glowColor(for touchStatus: String) -> (Color, Color, Color) {
        switch touchStatus {
        case "Perfect":
            return (Color.blue, Color.blue.opacity(0.6), Color.blue.opacity(0.3))
        case "Good":
            return (Color.green, Color.green.opacity(0.6), Color.green.opacity(0.3))
        default:
            return (Color.clear, Color.clear, Color.clear)
        }
    }
    
    private func audioPlaybackButtonTapped() {
        if isPlayingAudio {
            audioProcessor.audioPlayerNode?.pause()
            activeNotes.removeAll()
        } else {
            audioProcessor.audioPlayerNode?.play()
            if activeNotes.isEmpty {
                scheduleNotes()
            }
        }
        isPlayingAudio.toggle()
    }
}

struct SoundView: View {
    let backgroundImage = Image("002")
    var body: some View {
        SoundGameScreen(composition: Composition(notes: defaultComposition)).background(backgroundImage.resizable().ignoresSafeArea())
    }
}
