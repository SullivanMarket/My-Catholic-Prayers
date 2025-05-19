//
//  CatholicPsalm.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import Foundation

struct CatholicPsalm: Identifiable, Codable, Hashable {
    let id = UUID()
    let number: Int
    let text: String
    var commentary: [String]? = nil

    enum CodingKeys: String, CodingKey {
        case number, text
    }
}
