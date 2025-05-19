//
//  FavoritesPage.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/7/25.
//

import SwiftUI

struct FavoritesPage: View {
    let allPsalms: [CatholicPsalm]
    let allLitanies: [LitanyModel]
    let allNovenaSummaries: [NovenaSummary]
    @Binding var selection: NavigationSection?

    @ObservedObject var favoritesManager = FavoritePrayerManager.shared

    @State private var selectedPsalm: CatholicPsalm?
    @State private var selectedLitany: LitanyModel?
    @State private var selectedNovena: NovenaModel?

    var favoritePsalms: [CatholicPsalm] {
        allPsalms.filter {
            favoritesManager.isFavorite(prayerId: String($0.number), type: "psalm")
        }
    }

    var favoriteLitanies: [LitanyModel] {
        allLitanies.filter {
            favoritesManager.isFavorite(prayerId: $0.id, type: "litany")
        }
    }

    var favoriteNovenas: [NovenaSummary] {
        favoritesManager.favorites
            .filter { $0.type == "novena" }
            .compactMap { fav in allNovenaSummaries.first { $0.id == fav.prayerId } }
    }

    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    Text("❤️ Favorite Prayers")
                        .font(.largeTitle)
                        .bold()

                    if !favoritePsalms.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("📖 Favorite Psalms")
                                .font(.title)
                                .bold()
                            ForEach(favoritePsalms) { psalm in
                                Button {
                                    selectedPsalm = psalm
                                } label: {
                                    Text("📖 Psalm \(psalm.number)")
                                        .font(.title2)
                                        .foregroundColor(.accentColor)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.accentColor.opacity(0.1))
                                        .cornerRadius(20)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    if !favoriteLitanies.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("🙏 Favorite Litanies")
                                .font(.title)
                                .bold()
                            ForEach(favoriteLitanies) { litany in
                                Button {
                                    selectedLitany = litany
                                } label: {
                                    Text("🕊️ \(litany.title)")
                                        .font(.title2)
                                        .foregroundColor(.accentColor)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.accentColor.opacity(0.1))
                                        .cornerRadius(20)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }

                    if !favoriteNovenas.isEmpty {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("📅 Favorite Novenas")
                                .font(.title)
                                .bold()
                            ForEach(favoriteNovenas) { summary in
                                Button {
                                    selectedNovena = NovenaLoader.loadNovenaDetail(by: summary.id)
                                } label: {
                                    Text("🪷 \(summary.title)")
                                        .font(.title2)
                                        .foregroundColor(.accentColor)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 8)
                                        .background(Color.accentColor.opacity(0.1))
                                        .cornerRadius(20)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding()
            }
        }

        // MARK: - Popups with styled Close buttons
        .sheet(item: $selectedPsalm) { psalm in
            SheetWithClose {
                PsalmDetailView(psalm: psalm)
            }
        }
        .sheet(item: $selectedLitany) { litany in
            SheetWithClose {
                LitanyDetailView(litany: litany)
            }
        }
        .sheet(item: $selectedNovena) { novena in
            SheetWithClose {
                NovenaDetailView(novena: novena)
            }
        }
    }
}

// MARK: - Reusable Sheet Wrapper with Styled Close Button

private struct SheetWithClose<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                        .font(.headline)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 20)
                .padding(.top, 12)
            }

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
        }
        .frame(width: 600, height: 700)
        .background(Color("MainBackground").ignoresSafeArea())
    }
}
