//
//  CommentaryLoader.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import Foundation

// MARK: - Model
struct Commentary: Codable, Identifiable {
    let id: Int
    let commentary: String
}

// MARK: - Loader
struct CommentaryLoader {
    static func loadCommentary(for psalmNumber: Int) -> String? {
        guard let url = Bundle.main.url(forResource: "Commentary", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let allCommentaries = try? JSONDecoder().decode([Commentary].self, from: data) else {
            return nil
        }

        return allCommentaries.first(where: { $0.id == psalmNumber })?.commentary
    }
}
