//
//  NovenaDay.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/8/25.
//

import Foundation

struct NovenaDay: Codable, Hashable, Identifiable {
    var id: String { day }
    
    let day: String
    let title: String
    let text: String
    let refrain: String
    let concluding: String

    enum CodingKeys: String, CodingKey {
        case day, title, text, refrain, concluding
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Support either an integer or string for "day"
        if let intDay = try? container.decode(Int.self, forKey: .day) {
            day = String(intDay)
        } else {
            day = try container.decode(String.self, forKey: .day)
        }

        title = try container.decodeIfPresent(String.self, forKey: .title) ?? "Day \(day) Prayer"
        text = try container.decodeIfPresent(String.self, forKey: .text) ?? ""
        refrain = try container.decodeIfPresent(String.self, forKey: .refrain) ?? ""
        concluding = try container.decodeIfPresent(String.self, forKey: .concluding) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(day, forKey: .day)
        try container.encode(title, forKey: .title)
        try container.encode(text, forKey: .text)
        try container.encode(refrain, forKey: .refrain)
        try container.encode(concluding, forKey: .concluding)
    }
}
