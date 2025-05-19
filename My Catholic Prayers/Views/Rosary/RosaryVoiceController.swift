//
//  RosaryVoiceController.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/15/25.
//

import AVFoundation
import SwiftUI

class RosaryVoiceController: ObservableObject {
    private let synthesizer = AVSpeechSynthesizer()

    func speak(step: RosaryBeadStep, useLatin: Bool) {
        stop()
        let utterance = AVSpeechUtterance(string: useLatin ? step.latin : step.english)
        let selectedID = AppSettings.shared.selectedVoiceIdentifier
        if !selectedID.isEmpty,
           let voice = AVSpeechSynthesisVoice(identifier: selectedID) {
            utterance.voice = voice
        }
        utterance.rate = 0.48
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
