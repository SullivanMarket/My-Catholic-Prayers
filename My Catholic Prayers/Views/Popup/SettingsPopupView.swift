//
//  SettingsPopupView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/6/25.
//

import SwiftUI
import AVFoundation

struct SettingsPopupView: View {
    @EnvironmentObject var settings: AppSettings
    @Environment(\.dismiss) private var dismiss
    @AppStorage("useLatin") private var useLatin: Bool = false
    @AppStorage("rosaryAutoPlayEnabled") private var rosaryAutoPlayEnabled: Bool = false

    //private let speechQueue = DispatchQueue(label: "com.mycatholicprayers.speechQueue", qos: .userInitiated)
    private let speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack(spacing: 20) {
            Text("Appearance")
                .font(.title2)
                .bold()

            Picker("Appearance", selection: $settings.selectedAppearance) {
                Text("System").tag("system")
                Text("Light").tag("light")
                Text("Dark").tag("dark")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Divider()

            Toggle("Display Latin", isOn: $useLatin)
                .padding(.horizontal)

            Toggle("Auto Play Rosary", isOn: $rosaryAutoPlayEnabled)
                .padding(.horizontal)

            Divider()

            VStack(alignment: .leading, spacing: 6) {
                Text("Voice Selection")
                    .font(.headline)
                    .padding(.leading)

                HStack {
                    Picker("Voice", selection: $settings.selectedVoiceIdentifier) {
                        ForEach(availableVoices, id: \.identifier) { voice in
                            Text("\(voice.name) (\(voice.language))").tag(voice.identifier)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)

                    Button("Preview Voice") {
                        previewSelectedVoice()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.accentColor)
                    .clipShape(Capsule())
                    .padding(.horizontal, 5)
                    .padding(.vertical, 20)
                }
                .padding(.horizontal)
            }

            Spacer()

            Button(action: {
                dismiss()
            }) {
                Text("Close")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .padding(.top, 10)
            .buttonStyle(PlainButtonStyle())
        }
        .padding(30)
        .frame(width: 380)
    }

    private var availableVoices: [AVSpeechSynthesisVoice] {
        let enhanced = AVSpeechSynthesisVoice.speechVoices().filter {
            $0.quality == .enhanced && $0.language.starts(with: "en")
        }
        return enhanced.isEmpty
            ? AVSpeechSynthesisVoice.speechVoices().filter { $0.language.starts(with: "en") }
            : enhanced
    }

    private let speechQueue = DispatchQueue(label: "com.myapp.speechQueue", qos: .utility)

    private func previewSelectedVoice() {
        speechQueue.async {
            if speechSynthesizer.isSpeaking {
                speechSynthesizer.stopSpeaking(at: .immediate)
                Thread.sleep(forTimeInterval: 0.2)  // Give it a breather
            }

            let selectedID = settings.selectedVoiceIdentifier
            let selectedVoice = AVSpeechSynthesisVoice(identifier: selectedID) ?? AVSpeechSynthesisVoice.speechVoices().first

            guard let voice = selectedVoice else {
                print("❌ No available voice to use.")
                return
            }

            let utterance = AVSpeechUtterance(string: "Hail Mary, full of grace, the Lord is with thee.")
            utterance.voice = voice
            utterance.rate = AVSpeechUtteranceDefaultSpeechRate

            speechSynthesizer.speak(utterance)
        }
    }
}
