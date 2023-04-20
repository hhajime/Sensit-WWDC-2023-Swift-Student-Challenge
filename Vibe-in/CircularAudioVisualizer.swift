//
//  CircularAudioVisualizer.swift
//  Sensit
//
//  Created by Ha Jong Myeong on 2023/04/12.
//
import SwiftUI

struct CircularAudioVisualizer: View {
    @Binding var isPlayingAudio: Bool
    @Binding var touchStatus: String
    @Binding var streakCount: Int
    @State private var audioData: [Float] = Array(repeating: 0, count: Constants.numberOfBars)
    @State private var songStartTime: TimeInterval = 0
    @State private var wooferScale: CGFloat = 1.0
    @Binding var activeNotes: Set<UUID>
    
    var composition: Composition
    var currentTime: Double
    private let audioProcessor = AudioProcessor.sharedInstance
    private let updateTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    let innerRadius: CGFloat = 80
    let maxBarLength: CGFloat = 150
    
    var body: some View {
        VStack {
            audioBars
                .frame(width: 2 * (innerRadius + CGFloat(Constants.intensityThreshold * Constants.intensityFactor)),
                       height: 2 * (innerRadius + CGFloat(Constants.intensityThreshold * Constants.intensityFactor)))
        }
        .onReceive(updateTimer, perform: refreshAudioData)
    }
    
    private var audioBars: some View {
        ZStack {
            ForEach(0 ..< Constants.numberOfBars) { index in
                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        Color(
                            hue: 0.4 - Double((audioData[index] / Constants.intensityThreshold) / 5),
                            saturation: 1,
                            brightness: 1,
                            opacity: 0.7
                        )
                    )
                    .frame(width: 8, height: min(CGFloat(audioData[index] * Constants.intensityFactor), maxBarLength))
                    .modifier(NeonEffect(color: Color.white.opacity(0.75), radius: 4, x: 1, y: 1))
                    .offset(x: 0, y: -innerRadius - min(CGFloat(audioData[index] * Constants.intensityFactor / 2), maxBarLength / 2))
                    .rotationEffect(.degrees(Double(index) / Double(Constants.numberOfBars) * 360))
            }
            
            Circle()
                .fill(Color.black)
                .frame(width: 2 * innerRadius + wooferScale, height: 2 * innerRadius + wooferScale)
                .overlay(
                    Circle()
                        .stroke(Color(.white), lineWidth: 20)
                        .addGlowEffect(color1: Color(Color.RGBColorSpace.sRGB, red: 96/255, green: 252/255, blue: 255/255, opacity: 1), color2: Color(Color.RGBColorSpace.sRGB, red: 44/255, green: 158/255, blue: 238/255, opacity: 1), color3: Color(Color.RGBColorSpace.sRGB, red: 0/255, green: 129/255, blue: 255/255, opacity: 1))
                                  
                        .frame(width: (2 * innerRadius - 20) + wooferScale, height: (2 * innerRadius - 20) + wooferScale)
                )
                .gesture(TapGesture().onEnded { _ in
                    checkTouchAccuracy()
                })
            
        }
        .gesture(TapGesture().onEnded { _ in
            checkTouchAccuracy()
        })
    }
    
    private func refreshAudioData(_: Date) {
        if isPlayingAudio {
            if songStartTime == 0 {
                songStartTime = NSDate().timeIntervalSince1970
            }
            withAnimation(.easeOut(duration: 0.08)) {
                audioData = audioProcessor.frequencyMagnitudes.map {
                    min($0, Constants.intensityThreshold)
                }
                wooferScale = 1.0 + CGFloat(audioData.reduce(0, +) / Float(Constants.numberOfBars)) * 0.5
            }
//            detectMissedNotes()
        }
    }

    
//    private func detectMissedNotes() {
//        if let earliestNote = activeNotes.map({ (id: $0, time: noteTime(forNoteWithID: $0)) }).min(by: { $0.time! < $1.time! }),
//            let earliestNoteTime = earliestNote.time {
//
//            let timeDifference = abs(currentTime - earliestNoteTime)
//
//            if timeDifference > Constants.goodThreshold {
//                print(timeDifference)
//                touchStatus = "Wrong"
//                streakCount = 0
//                print("wrong")
//            }
//        }
//    }

    
    private func noteTime(forNoteWithID id: UUID) -> Double? {
        composition.notes.first(where: { $0.id == id })?.startTime
    }

    
    private func checkTouchAccuracy() {
        if let closestNote = activeNotes.map({ (id: $0, time: noteTime(forNoteWithID: $0)) }).min(by: { abs($0.time! - currentTime) < abs($1.time! - currentTime) }),
            let closestNoteTime = closestNote.time {
            let timeDifference = abs(closestNoteTime - currentTime)

//            print("currentTime: \(currentTime)")
//            print("closestNoteTime: \(closestNoteTime)")
//            print("timeDifference: \(timeDifference)")

            if timeDifference <= Constants.perfectThreshold && timeDifference >= 0.5 {
                touchStatus = "Perfect"
                streakCount += 1
                activeNotes.remove(closestNote.id)
            } else if timeDifference <= Constants.goodThreshold {
                touchStatus = "Good"
                streakCount += 1
                activeNotes.remove(closestNote.id)
            }
        }
    }
}


