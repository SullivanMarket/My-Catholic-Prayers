//
//  ExaminationLoader.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/23/25.
//

import Foundation

struct ExaminationLoader {
    static func loadExamination(framework: ExaminationFramework, role: ExaminationRole) -> Examination? {
        let filename = "examination_\(framework.rawValue)_\(role.rawValue)"

        // Debug bundle info
        print("🧪 Bundle path: \(Bundle.main.bundlePath)")
        if let resourcePath = Bundle.main.resourcePath {
            print("📁 Resource path contents:")
            do {
                let contents = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
                contents.forEach { print("   • \($0)") }
            } catch {
                print("❌ Failed to list bundle contents: \(error)")
            }

            let dataExaminationPath = resourcePath + "/Data/Examination"
            print("📁 Attempting to list Data/Examination contents at: \(dataExaminationPath)")
            do {
                let subContents = try FileManager.default.contentsOfDirectory(atPath: dataExaminationPath)
                subContents.forEach { print("   - \($0)") }
            } catch {
                print("❌ Error reading Data/Examination: \(error)")
            }
        }

        // Try loading with subdirectory
        if let url = Bundle.main.url(forResource: filename, withExtension: "json", subdirectory: "Data/Examination") {
            print("✅ Found examination file at (subdirectory): \(url.path)")
            do {
                let data = try Data(contentsOf: url)
                return try JSONDecoder().decode(Examination.self, from: data)
            } catch {
                print("❌ Failed to decode with subdirectory: \(error)")
            }
        } else {
            print("⚠️ File not found with subdirectory path")
        }

        // Fallback: Try without subdirectory
        if let fallbackURL = Bundle.main.url(forResource: filename, withExtension: "json") {
            print("✅ Found examination file at (root): \(fallbackURL.path)")
            do {
                let data = try Data(contentsOf: fallbackURL)
                return try JSONDecoder().decode(Examination.self, from: data)
            } catch {
                print("❌ Failed to decode from root: \(error)")
            }
        } else {
            print("❌ File not found in root: \(filename).json")
        }

        return nil
    }
}

// MARK: - Supporting Enums (moved outside the view)
enum ExaminationFramework: String, CaseIterable {
    case tenCommandments = "10commandments"
    case virtuesVices = "virtuesvices"

    var displayName: String {
        switch self {
        case .tenCommandments: return "Ten Commandments"
        case .virtuesVices: return "Virtues & Vices"
        }
    }
}

enum ExaminationRole: String, CaseIterable {
    case child, adult, husband, wife, father, mother, priest, religious

    var displayName: String {
        self.rawValue.capitalized
    }
}
