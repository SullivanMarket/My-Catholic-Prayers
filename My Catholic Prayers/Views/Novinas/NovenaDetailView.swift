//
//  NovenaDetailView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/7/25.
//


import SwiftUI
import Foundation

struct NovenaDetailView: View {
    let novena: NovenaModel
    @State private var currentDayIndex = 0
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var favorites = FavoritePrayerManager.shared

    var body: some View {
        let currentDay = novena.days[currentDayIndex]

        VStack(spacing: 16) {
            // Header
            HStack {
                Text("\(novena.title) :: Day \(currentDay.day)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)

                Spacer()

                Button(action: {
                    favorites.toggleFavorite(prayerId: novena.id, type: "novena")
                }) {
                    Image(systemName: favorites.isFavorite(prayerId: novena.id, type: "novena") ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.red)
                }
                .padding(.leading, 8)
            }

            // Scrollable Text Section
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text(currentDay.text)
                        .font(.custom("Georgia-Italic", size: 28))
                        .foregroundColor(.primary)
                        .lineSpacing(5)

                    if !currentDay.refrain.isEmpty {
                        Divider()
                        Text(currentDay.refrain)
                            .font(.custom("Georgia-Italic", size: 28))
                            .italic()
                            .foregroundColor(.primary)
                            .lineSpacing(5)
                    }

                    if !currentDay.concluding.isEmpty {
                        Divider()
                        Text(currentDay.concluding)
                            .font(.custom("Georgia-Italic", size: 28))
                            .foregroundColor(.primary)
                            .lineSpacing(5)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(NSColor.controlBackgroundColor))
                        .shadow(radius: 1)
                )
                .padding(.horizontal)
            }

            // Navigation Buttons
            HStack {
                Button(action: goToPreviousDay) {
                    Label("Previous", systemImage: "chevron.left")
                        .font(.headline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(currentDayIndex == 0)

                Spacer()

                Button(action: goToNextDay) {
                    Label("Next", systemImage: "chevron.right")
                        .font(.headline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(currentDayIndex >= novena.days.count - 1)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color("MainBackground").ignoresSafeArea())
        .frame(minWidth: 600, minHeight: 500) // Optional fixed size
    }

    private func goToPreviousDay() {
        if currentDayIndex > 0 {
            currentDayIndex -= 1
        }
    }

    private func goToNextDay() {
        if currentDayIndex < novena.days.count - 1 {
            currentDayIndex += 1
        }
    }
}
