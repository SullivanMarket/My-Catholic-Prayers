//
//  FavoritePrayer.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/7/25.
//

import Foundation

struct FavoritePrayer: Codable, Identifiable, Equatable {
    var prayerId: String   // e.g., "23" for Psalm, or "litany-of-trust"
    var type: String       // e.g., "psalm", "litany"

    var id: String { "\(type)-\(prayerId)" }  // Satisfies Identifiable protocol

    static func == (lhs: FavoritePrayer, rhs: FavoritePrayer) -> Bool {
        return lhs.id == rhs.id
    }
}
