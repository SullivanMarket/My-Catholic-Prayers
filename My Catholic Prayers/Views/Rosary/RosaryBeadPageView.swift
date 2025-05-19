//
//  RosaryBeadPageView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import SwiftUI

struct RosaryBeadPageView: View {
    let section: RosarySection
    let steps: [RosaryBeadStep]
    @Binding var currentIndex: Int
    @AppStorage("useLatin") private var useLatin: Bool = false
    @AppStorage("rosaryAutoPlayEnabled") private var rosaryAutoPlayEnabled: Bool = false
    @StateObject private var voiceController = RosaryVoiceController()

    private let mysteryStartIndices = [8, 21, 34, 47, 60]

    private var fixedTitle: String {
        switch section {
        case .joyful: return "The Joyful Mysteries of the Rosary"
        case .sorrowful: return "The Sorrowful Mysteries of the Rosary"
        case .glorious: return "The Glorious Mysteries of the Rosary"
        case .luminous: return "The Luminous Mysteries of the Rosary"
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            // Top Row: Fixed mystery group title + autoplay toggle
            HStack {
                Text(fixedTitle)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)

                Spacer()

                Toggle("Auto Play", isOn: $rosaryAutoPlayEnabled)
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            }
            .padding(.horizontal)

            // Shortcut buttons
            HStack {
                ForEach(0..<5, id: \.self) { i in
                    Button("Mystery \(i + 1)") {
                        if mysteryStartIndices.indices.contains(i) {
                            currentIndex = mysteryStartIndices[i]
                            speakIfEnabled()
                        }
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .buttonStyle(.bordered)
                }
            }

            // Prayer content
            if currentIndex < steps.count {
                let step = steps[currentIndex]

                VStack(alignment: .leading, spacing: 12) {
                    Text(step.title)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)

                    Text(useLatin ? step.latin : step.english)
                        .font(.custom("Snell Roundhand", size: 28))
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 60)
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 800, maxHeight: 800)
                .background(Color.accentColor.opacity(0.2))
                .cornerRadius(12)
                .padding(.horizontal)
                .onAppear {
                    speakIfEnabled()
                }
            }

            // Bead info
            VStack(spacing: 4) {
                Text("Bead \(steps[safe: currentIndex]?.beadNumber ?? 0) of \(steps.count)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Nav buttons
            HStack {
                Button {
                    if currentIndex > 0 {
                        currentIndex -= 1
                        speakIfEnabled()
                    }
                } label: {
                    Label("Previous", systemImage: "arrow.left")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .frame(minWidth: 140)
                        .background(currentIndex > 0 ? Color.accentColor : Color.gray.opacity(0.4))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(currentIndex == 0)

                Spacer()

                Toggle(isOn: $useLatin) {
                    Text("Show Latin")
                        .foregroundColor(.primary)
                }
                .toggleStyle(SwitchToggleStyle())

                Spacer()

                Button {
                    if currentIndex < steps.count - 1 {
                        currentIndex += 1
                        speakIfEnabled()
                    }
                } label: {
                    Label("Next", systemImage: "arrow.right")
                        .font(.system(size: 16, weight: .semibold))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .frame(minWidth: 140)
                        .background(currentIndex < steps.count - 1 ? Color.accentColor : Color.gray.opacity(0.4))
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(currentIndex == steps.count - 1)
            }
            .padding(.bottom, 20)
            .padding(.horizontal)
        }
    }

    private func speakIfEnabled() {
        guard currentIndex < steps.count else { return }
        if rosaryAutoPlayEnabled {
            voiceController.speak(step: steps[currentIndex], useLatin: useLatin)
        }
    }
}

// Safe lookup
extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
