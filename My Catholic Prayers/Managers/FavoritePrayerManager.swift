//
//  FavoritePrayerManager.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/7/25.
//

import Foundation

class FavoritePrayerManager: ObservableObject {
    static let shared = FavoritePrayerManager()

    @Published var favorites: [FavoritePrayer] = []

    private let filename = "favorites.json"

    private init() {
        loadFavorites()
    }

    func isFavorite(prayerId: String, type: String) -> Bool {
        favorites.contains { $0.prayerId == prayerId && $0.type == type }
    }

    func toggleFavorite(prayerId: String, type: String) {
        let item = FavoritePrayer(prayerId: prayerId, type: type)
        if let index = favorites.firstIndex(of: item) {
            favorites.remove(at: index)
        } else {
            favorites.append(item)
        }
        saveFavorites()
    }

    private func getURL() -> URL {
        let folder = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        try? FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
        return folder.appendingPathComponent(filename)
    }

    func saveFavorites() {
        let url = getURL()
        do {
            let data = try JSONEncoder().encode(favorites)
            try data.write(to: url)
            print("✅ Saved favorites to \(url.path)")
        } catch {
            print("❌ Failed to save favorites: \(error)")
        }
    }

    func loadFavorites() {
        let url = getURL()
        do {
            let data = try Data(contentsOf: url)
            favorites = try JSONDecoder().decode([FavoritePrayer].self, from: data)
            print("✅ Loaded favorites from \(url.path)")
        } catch {
            print("❌ Failed to load favorites: \(error)")
            favorites = []
        }
    }
}
