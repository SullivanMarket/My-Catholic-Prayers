//
//  PsalmDetailView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import SwiftUI

struct PsalmDetailView: View {
    let psalm: CatholicPsalm
    @ObservedObject private var favorites = FavoritePrayerManager.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Psalm \(psalm.number)")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Button(action: {
                        favorites.toggleFavorite(prayerId: "\(psalm.number)", type: "psalm")
                    }) {
                        Image(systemName: favorites.isFavorite(prayerId: "\(psalm.number)", type: "psalm") ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.system(size: 28))  // 🔴 Bigger heart
                    }
                    .buttonStyle(PlainButtonStyle())
                }

                let lines = psalm.text
                    .components(separatedBy: .newlines)
                    .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
                    .filter { !$0.isEmpty && !$0.matchesOnlyNumberDot() } // ✅ remove lines like "2." or "4."

                ForEach(Array(lines.enumerated()), id: \.offset) { index, line in
                    HStack(alignment: .top, spacing: 10) {
                        Text("\(index + 1).")
                            .font(.body)
                            .bold()
                        Text(line)
                            .font(.custom("Snell Roundhand", size: 26))  // ✅ Bigger font
                    }
                }

                if let commentary = psalm.commentary {
                    Divider()
                    Text("Reflection")
                        .font(.title2)
                        .bold()
                    ForEach(commentary, id: \.self) { paragraph in
                        Text(paragraph)
                            .padding(.bottom, 8)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Helper for detecting lines like "1." or "23."
extension String {
    func matchesOnlyNumberDot() -> Bool {
        return self.range(of: #"^\d+\.$"#, options: .regularExpression) != nil
    }
}
