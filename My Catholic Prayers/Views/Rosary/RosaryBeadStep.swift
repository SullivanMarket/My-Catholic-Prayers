//
//  RosaryBeadStep.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import Foundation

struct RosaryBeadStep: Identifiable {
    let id = UUID()
    let beadNumber: Int
    let title: String
    let english: String
    let latin: String
}
