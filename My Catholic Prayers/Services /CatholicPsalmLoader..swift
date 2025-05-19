//
//  CatholicPsalmLoader.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import Foundation

struct CatholicPsalmLoader {
    static func loadPsalms() -> [CatholicPsalm] {
        guard let url = Bundle.main.url(forResource: "CatholicPsalms", withExtension: "json") else {
            print("❌ Could not find CatholicPsalms.json in bundle.")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([CatholicPsalm].self, from: data)
            print("✅ Loaded \(decoded.count) psalms")
            return decoded
        } catch {
            print("❌ Error decoding CatholicPsalms.json: \(error)")
            return []
        }
    }
}
