//
//  NavigationSection.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import Foundation

enum NavigationSection: Hashable {
    case home
    case psalmsHome
    case psalm(CatholicPsalm)
    case litaniesHome
    case litany(LitanySummary)
    case favorites
    case novenasHome
    case novena(NovenaSummary)
    case stations
    case rosaryHome
    case rosaryPrayers
    case rosary(RosarySection)
    case divineMercy
    case examination  // ✅ NEW

    static func == (lhs: NavigationSection, rhs: NavigationSection) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home),
             (.psalmsHome, .psalmsHome),
             (.litaniesHome, .litaniesHome),
             (.favorites, .favorites),
             (.novenasHome, .novenasHome),
             (.stations, .stations),
             (.rosaryHome, .rosaryHome),
             (.rosaryPrayers, .rosaryPrayers),
             (.divineMercy, .divineMercy),
             (.examination, .examination):  // ✅ NEW
            return true
        case let (.psalm(a), .psalm(b)):
            return a.id == b.id
        case let (.litany(a), .litany(b)):
            return a.id == b.id
        case let (.novena(a), .novena(b)):
            return a.id == b.id
        case let (.rosary(a), .rosary(b)):
            return a == b
        default:
            return false
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .home:
            hasher.combine("home")
        case .psalmsHome:
            hasher.combine("psalmsHome")
        case .litaniesHome:
            hasher.combine("litaniesHome")
        case .favorites:
            hasher.combine("favorites")
        case .psalm(let psalm):
            hasher.combine("psalm")
            hasher.combine(psalm.id)
        case .litany(let litany):
            hasher.combine("litany")
            hasher.combine(litany.id)
        case .novenasHome:
            hasher.combine("novenasHome")
        case .novena(let novena):
            hasher.combine("novena")
            hasher.combine(novena.id)
        case .stations:
            hasher.combine("stations")
        case .rosaryHome:
            hasher.combine("rosaryHome")
        case .rosaryPrayers:
            hasher.combine("rosaryPrayers")
        case .rosary(let section):
            hasher.combine("rosary")
            hasher.combine(section)
        case .divineMercy:
            hasher.combine("divineMercy")
        case .examination:  // ✅ NEW
            hasher.combine("examination")
        }
    }
}
