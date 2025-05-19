//
//  RosaryHomeView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import SwiftUI

struct RosaryHomeView: View {
    @Binding var selection: NavigationSection?
    @EnvironmentObject var settings: AppSettings
    @AppStorage("rosaryAutoPlayEnabled") private var rosaryAutoPlayEnabled: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("Choose a Mystery Set")
                    .font(.title)
                    .bold()
                    .padding(.top, 20)

                // Auto Play Toggle (side-by-side with label)
                HStack {
                    Toggle(isOn: $rosaryAutoPlayEnabled) {
                        Text("Auto Play Audio")
                            .font(.subheadline)
                            .bold()
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .accentColor))
                }
                .padding(.horizontal, 80)

                // Mystery Buttons
                ForEach(RosarySection.allCases, id: \.self) { section in
                    Button(action: {
                        selection = .rosary(section)
                    }) {
                        Text(label(for: section))
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.accentColor.opacity(0.15))
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle("My Catholic Prayers")
    }

    private func label(for section: RosarySection) -> String {
        switch section {
        case .joyful:
            return "Joyful Mysteries (Monday & Saturday)"
        case .sorrowful:
            return "Sorrowful Mysteries (Tuesday & Friday)"
        case .glorious:
            return "Glorious Mysteries (Wednesday & Sunday)"
        case .luminous:
            return "Luminous Mysteries (Thursday)"
        }
    }
}
