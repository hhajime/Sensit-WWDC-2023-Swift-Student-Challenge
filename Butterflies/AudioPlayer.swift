//
//  AudioPlayer.swift
//  Sensit
//
//  Created by Ha Jong Myeong on 2023/04/06.
//

import AVFoundation

class AudioPlayer: ObservableObject {
    private var audioPlayer: AVAudioPlayer?
    
    func play(_ soundFile: String, ofType fileType: String = "mp3") {
        if let path = Bundle.main.path(forResource: soundFile, ofType: fileType) {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Error playing audio: \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}
