//
//  NovenaModel.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/8/25.
//

import Foundation

struct NovenaModel: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let days: [NovenaDay]
}

struct Novena: Identifiable, Codable {
    let id: String
    let title: String
    let startDate: String
    let feastDay: String
    let birth: String
    let death: String
    let patronage: String
    let days: [NovenaDay]
}
