//
//  LitanyModel.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import Foundation

// Represents a single litany file (with raw string content)
struct LitanyModel: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var content: String // ✅ Matches your JSON structure
}

// Represents a short summary shown in grouped lists
struct LitanySummary: Identifiable, Codable, Hashable {
    var id: String
    var title: String
}

// Used for grouping litanies under categories
struct LitanyCategory: Identifiable, Codable, Hashable {
    var category: String
    var litanies: [LitanySummary]

    var id: String { category }
}
