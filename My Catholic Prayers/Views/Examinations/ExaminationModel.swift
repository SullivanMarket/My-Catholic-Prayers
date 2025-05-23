//
//  ExaminationModel.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/23/25.
//

import Foundation

struct Examination: Codable {
    let framework: String
    let role: String
    var sections: [ExaminationSection] // ✅ changed from `let` to `var`
}

struct ExaminationSection: Codable, Identifiable {
    let title: String
    var questions: [ExaminationQuestion]

    var id: String { title }
}

struct ExaminationQuestion: Codable, Identifiable {
    let id: String
    let text: String
    var checked: Bool
}
