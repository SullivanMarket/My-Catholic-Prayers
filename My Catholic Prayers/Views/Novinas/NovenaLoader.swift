//
//  NovenaLoader.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/8/25.
//

import Foundation

struct NovenaSummary: Identifiable, Codable {
    let id: String
    let title: String
    let startDate: String
    let feastDay: String
    let patronage: String?
}

struct NovenaLoader {
    static func loadNovenaSummaries() -> [NovenaSummary] {
        guard let url = Bundle.main.url(forResource: "novenas", withExtension: "json") else {
            print("❌ Could not find novenas.json")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let summaries = try JSONDecoder().decode([NovenaSummary].self, from: data)
            print("✅ Loaded \(summaries.count) novena summaries")
            return summaries
        } catch {
            print("❌ Failed to decode novenas.json: \(error)")
            return []
        }
    }

    static func loadNovenaDetail(by id: String) -> NovenaModel? {
        guard let url = Bundle.main.url(forResource: id, withExtension: "json") else {
            print("❌ File not found: \(id).json")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let novena = try JSONDecoder().decode(NovenaModel.self, from: data)
            return novena
        } catch {
            print("❌ Failed to decode \(id).json: \(error)")
            return nil
        }
    }
}
