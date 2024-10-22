//
//  SoundsView.swift
//  swiftUIContinuedLearning
//
//  Created by MacBook on 22/10/2024.
//

import SwiftUI
import AVKit

class SoundManager {
    static let instance = SoundManager()
    
    enum Sounds: String {
        case tada
        case badum
    }
    
    var player: AVAudioPlayer?
    
    func playSound(sound: Sounds) -> Void {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url )
            player?.play()
        } catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
    }
}

struct SoundsView: View {
    
    var soundManager: SoundManager = SoundManager.instance
    
    var body: some View {
        VStack(spacing: 40) {
            Button("play sound 1") {
                soundManager.playSound(sound: SoundManager.Sounds.tada)
            }
            Button("play sound 2") {
                soundManager.playSound(sound: SoundManager.Sounds.badum)
            }
        }
    }
}

#Preview {
    SoundsView()
}
