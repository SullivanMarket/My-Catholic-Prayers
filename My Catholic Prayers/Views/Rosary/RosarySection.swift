//
//  RosarySection .swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import Foundation

enum RosarySection: String, CaseIterable, Hashable {
    case joyful
    case sorrowful
    case glorious
    case luminous

    var displayName: String {
        switch self {
        case .joyful: return "My Catholic Prayers"
        case .sorrowful: return "My Catholic Prayers"
        case .glorious: return "My Catholic Prayers"
        case .luminous: return "My Catholic Prayers"
        }
    }
}
