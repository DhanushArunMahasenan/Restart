//
//  AudioPlayer.swift
//  Restart
//
//  Created by Dhanush Arun on 10/15/22.
//

import Foundation
import AVFoundation



var audioPlayer: AVAudioPlayer?


func PlaySound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
            
        }
        
        catch {
            print("Error: Could not play the sound file.")
            
        }
        
    }
    
}
