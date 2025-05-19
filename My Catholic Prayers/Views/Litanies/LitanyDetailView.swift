//
//  LitanyDetailView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/6/25.
//

import SwiftUI

struct LitanyDetailView: View {
    let litany: LitanyModel
    @ObservedObject var favorites = FavoritePrayerManager.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title and Favorite Heart
                HStack {
                    Text(litany.title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.primary)

                    Spacer()

                    Button(action: {
                        favorites.toggleFavorite(prayerId: litany.id, type: "litany")
                    }) {
                        Image(systemName: favorites.isFavorite(prayerId: litany.id, type: "litany") ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.plain)
                }

                // Decode and style content
                let formattedContent = litany.content
                    .replacingOccurrences(of: "\\n", with: "\n")
                    .replacingOccurrences(of: "\\t", with: "\t")

                HStack(alignment: .top) {
                    Color.clear
                        .frame(width: 36) // About 0.5 inch
                    Text(formattedContent)
                        .font(.custom("Snell Roundhand", size: 30))
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .padding(.top)
                }

                Spacer()
            }
            .padding()
        }
        .background(Color("MainBackground").ignoresSafeArea())
        .navigationTitle("My Catholic Prayers")
    }
}
