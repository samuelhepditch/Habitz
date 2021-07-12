//
//  SoundManager.swift
//  Habitz
//
//  Created by Sam on 2021-07-11.
//

import Foundation
import AVKit

class SoundManager: ObservableObject {
    static let instance = SoundManager()
    var player:AVAudioPlayer?
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "click", withExtension: ".mp3") else { return }
        do{
          player = try AVAudioPlayer(contentsOf: url)
          player?.play()
        } catch let error {
          print("Error playing sound. \(error.localizedDescription)")
        }
    }
}
