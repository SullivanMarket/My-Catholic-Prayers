//
//  LitanyLoader.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import Foundation

// Wraps the top-level object in litanies.json
struct LitanyCategoryWrapper: Codable {
    let categories: [LitanyCategory]
}

class LitanyLoader {
    private static var cleanedLitanyIds: [String] = []

    // Load list of categories and summarized litanies from litanies.json
    static func loadLitanyCategories() -> [LitanyCategory] {
        if let url = Bundle.main.url(forResource: "litanies", withExtension: "json") {
            print("✅ Found litanies.json at: \(url)")
            do {
                let data = try Data(contentsOf: url)
                print("✅ Successfully read data from litanies.json")
                let wrapper = try JSONDecoder().decode(LitanyCategoryWrapper.self, from: data)
                print("✅ Successfully decoded litanies.json into \(wrapper.categories.count) categories")
                return wrapper.categories
            } catch {
                print("❌ Error decoding litanies.json: \(error)")
            }
        } else {
            print("❌ Could not find litanies.json in the main bundle")
        }
        return []
    }

    // Load full content of a selected litany by ID
    static func loadLitanyDetail(by id: String) -> LitanyModel? {
        let filename = "\(id).json"

        if let url = Bundle.main.url(forResource: id, withExtension: "json") {
            print("✅ Found litany file for id '\(id)' at: \(url)")
            do {
                let data = try Data(contentsOf: url)
                var litany = try JSONDecoder().decode(LitanyModel.self, from: data)

                // Clean content if needed
                let cleaned = cleanLitanyContent(litany.content, litanyId: id)
                litany.content = cleaned
                return litany
            } catch {
                print("❌ Failed to decode litany file for id '\(id)': \(error)")
            }
        } else {
            print("❌ Could not find litany file for id '\(id)' — expected file: \(filename)")
        }
        return nil
    }

    // Flatten all litanies from categories into [LitanyModel] with placeholder content
    static func loadAllLitanies() -> [LitanyModel] {
        guard let url = Bundle.main.url(forResource: "litanies", withExtension: "json") else {
            print("❌ Could not find litanies.json in the main bundle")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let wrapper = try JSONDecoder().decode(LitanyCategoryWrapper.self, from: data)
            var fullModels: [LitanyModel] = []

            for category in wrapper.categories {
                for summary in category.litanies {
                    if let litany = loadLitanyDetail(by: summary.id) {
                        // Use full cleaned content
                        var model = litany
                        model.title = summary.title // ensure title is preserved
                        fullModels.append(model)
                    } else {
                        // Fallback in case individual file is missing
                        fullModels.append(LitanyModel(id: summary.id, title: summary.title, content: "⚠️ Could not load content."))
                    }
                }
            }

            print("✅ Loaded \(fullModels.count) litanies with real content from individual files")

            if !cleanedLitanyIds.isEmpty {
                writeCleanupLog(ids: cleanedLitanyIds)
            }

            return fullModels
        } catch {
            print("❌ Failed to decode litanies.json in loadAllLitanies: \(error)")
            return []
        }
    }

    // Load actual favorite litanies by ID using their real content
    static func loadFavoriteLitanies(from favoriteIds: [String]) -> [LitanyModel] {
        var loaded: [LitanyModel] = []

        for id in favoriteIds {
            if let litany = loadLitanyDetail(by: id) {
                loaded.append(litany)
            } else {
                print("⚠️ Skipped missing or invalid litany with id: \(id)")
            }
        }

        if !cleanedLitanyIds.isEmpty {
            writeCleanupLog(ids: cleanedLitanyIds)
        }

        return loaded
    }

    // MARK: - Cleaning Logic

    private static func cleanLitanyContent(_ raw: String, litanyId: String) -> String {
        var cleaned = raw
        var wasCleaned = false

        if cleaned.hasPrefix("\"\nBack to the Litanies Index\n") {
            cleaned = cleaned.replacingOccurrences(of: "\"\nBack to the Litanies Index\n", with: "")
            wasCleaned = true
        } else if cleaned.hasPrefix("Back to the Litanies Index\n") {
            cleaned = cleaned.replacingOccurrences(of: "Back to the Litanies Index\n", with: "")
            wasCleaned = true
        }

        if let sourceRange = cleaned.range(of: "\n[Source: ") {
            cleaned.removeSubrange(sourceRange.lowerBound..<cleaned.endIndex)
            wasCleaned = true
        }

        if cleaned.hasSuffix("\"") {
            cleaned.removeLast()
            wasCleaned = true
        }

        if wasCleaned {
            print("⚠️ Cleaned litany content for: \(litanyId)")
            cleanedLitanyIds.append(litanyId)
            updateLitanyJSONFile(id: litanyId, cleanedContent: cleaned)
        }

        return cleaned
    }

    private static func updateLitanyJSONFile(id: String, cleanedContent: String) {
        let updatedModel = LitanyModel(id: id, title: "", content: cleanedContent)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        do {
            let data = try encoder.encode(updatedModel)

            let fileManager = FileManager.default
            if let docs = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
                let path = docs.appendingPathComponent("\(id).json")
                try fileManager.createDirectory(at: docs, withIntermediateDirectories: true)
                try data.write(to: path)
                print("✅ Saved cleaned JSON to: \(path.path)")
            }
        } catch {
            print("❌ Failed to save cleaned file for \(id): \(error)")
        }
    }

    private static func writeCleanupLog(ids: [String]) {
        let logText = "Cleaned Litany Files (\(ids.count)):\n\n" + ids.joined(separator: "\n") + "\n"
        let fileManager = FileManager.default

        if let dir = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first {
            let path = dir.appendingPathComponent("litany_cleanup_log.txt")
            do {
                try logText.write(to: path, atomically: true, encoding: .utf8)
                print("📝 Cleanup log written to: \(path.path)")
            } catch {
                print("❌ Failed to write cleanup log: \(error)")
            }
        }
    }
}
