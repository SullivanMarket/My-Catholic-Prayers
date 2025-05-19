//
//  RosaryDetailView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import SwiftUI

struct RosaryDetailView: View {
    let section: RosarySection
    @AppStorage("useLatin") private var useLatin: Bool = false
    @State private var steps: [RosaryBeadStep] = []
    @State private var currentIndex: Int = 0

    var body: some View {
        VStack {
            if steps.indices.contains(currentIndex) {
                RosaryBeadPageView(section: section, steps: steps, currentIndex: $currentIndex)
            } else {
                Text("❌ Invalid step index: \(currentIndex)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            loadSteps()
        }
        .navigationTitle(section.displayName)
    }

    private func loadSteps() {
        guard let url = Bundle.main.url(forResource: "scriptural_rosary_full", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("❌ Failed to load rosary JSON file")
            return
        }

        do {
            let sets = try JSONDecoder().decode([RosaryData].self, from: data)
            if let match = sets.first(where: { $0.set.lowercased() == section.rawValue.lowercased() }) {
                steps = RosaryLoader.buildBeadSteps(from: match)
                print("✅ Loaded \(steps.count) steps for \(section.rawValue.capitalized) mystery")
            } else {
                print("❌ No matching set found for \(section.rawValue)")
            }
        } catch {
            print("❌ Rosary JSON decoding error: \(error)")
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 Raw JSON preview:\n\(jsonString.prefix(500))...")
            }
        }
    }
}

// MARK: - Rosary Data Models

struct RosaryData: Decodable {
    let set: String
    let mysteries: [RosaryMystery]
}

struct RosaryMystery: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let verses: [RosaryVerse]

    private enum CodingKeys: String, CodingKey {
        case title
        case verses
    }
}

struct RosaryVerse: Decodable {
    let english: String
    let latin: String
}

// MARK: - Step Builder

enum RosaryLoader {
    static func buildBeadSteps(from data: RosaryData) -> [RosaryBeadStep] {
        var steps: [RosaryBeadStep] = []
        var bead = 1

        // Sign of the Cross
        steps.append(RosaryBeadStep(
            beadNumber: bead, title: "Sign of the Cross",
            english: "In the name of the Father, and of the Son, and of the Holy Spirit. Amen.",
            latin: "In nómine Patris, et Fílii, et Spíritus Sancti. Amen."
        )); bead += 1

        // Apostles’ Creed
        steps.append(RosaryBeadStep(
            beadNumber: bead, title: "Apostles’ Creed",
            english: """
I believe in God, the Father almighty, Creator of heaven and earth,
and in Jesus Christ, His only Son, our Lord,
who was conceived by the Holy Spirit, born of the Virgin Mary,
suffered under Pontius Pilate, was crucified, died and was buried;
He descended into hell; on the third day He rose again from the dead;
He ascended into heaven, and is seated at the right hand of God the Father almighty;
from there He will come to judge the living and the dead.

I believe in the Holy Spirit,
the holy catholic Church,
the communion of saints,
the forgiveness of sins,
the resurrection of the body,
and life everlasting. Amen.
""",
            latin: """
Credo in Deum Patrem omnipoténtem,
Creatórem cæli et terræ.

Et in Iesum Christum, Fílium eius únicum, Dóminum nostrum,
qui concéptus est de Spíritu Sancto,
natus ex María Vírgine,
passus sub Póntio Piláto, crucifíxus, mórtuus, et sepúltus,
descéndit ad ínferos; tértia die resurréxit a mórtuis;
ascéndit ad cælos, sedet ad déxteram Dei Patris omnipoténtis,
inde ventúrus est iudicáre vivos et mórtuos.

Credo in Spíritum Sanctum,
sanctam Ecclésiam cathólicam,
sanctórum communiónem,
remissiónem peccatórum,
cárnis resurrectiónem,
vitam ætérnam. Amen.
"""
        )); bead += 1

        // Our Father
        steps.append(RosaryBeadStep(
            beadNumber: bead, title: "Our Father",
            english: """
Our Father, who art in heaven, hallowed be Thy name;
Thy kingdom come; Thy will be done on earth as it is in heaven.
Give us this day our daily bread;
and forgive us our trespasses,
as we forgive those who trespass against us;
and lead us not into temptation, but deliver us from evil. Amen.
""",
            latin: """
Pater noster, qui es in cælis, sanctificétur nomen tuum.
Advéniat regnum tuum. Fiat voluntas tua, sicut in cælo, et in terra.
Panem nostrum cotidiánum da nobis hódie,
et dimítte nobis débita nostra sicut et nos dimíttimus debitóribus nostris.
Et ne nos indúcas in tentatiónem, sed líbera nos a malo. Amen.
"""
        )); bead += 1

        // Hail Marys (Intro)
        let intentions = [
            ("faith", "fidem"),
            ("hope", "spem"),
            ("charity", "caritatem")
        ]

        for (i, intention) in intentions.enumerated() {
            let (englishIntention, latinIntention) = intention
            steps.append(RosaryBeadStep(
                beadNumber: bead,
                title: "Hail Mary \(i + 1)",
                english:
        """
        This Hail Mary is for an increase in **\(englishIntention.capitalized)**.

        Hail Mary, full of grace, the Lord is with thee;
        blessed art thou among women,
        and blessed is the fruit of thy womb, Jesus.
        Holy Mary, Mother of God, pray for us sinners,
        now and at the hour of our death. Amen.
        """,
                latin:
        """
        Ave María haec est pro incremento **\(latinIntention)**.

        Ave María, grátia plena, Dóminus tecum.
        Benedícta tu in muliéribus,
        et benedíctus fructus ventris tui, Iesus.
        Sancta María, Mater Dei, ora pro nobis peccatóribus,
        nunc et in hora mortis nostræ. Amen.
        """
            ))
            bead += 1
        }

        // Glory Be
        steps.append(RosaryBeadStep(
            beadNumber: bead, title: "Glory Be",
            english: "Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.",
            latin: "Glória Patri, et Fílio, et Spirítui Sancto. Sicut erat in princípio, et nunc, et semper, et in sǽcula sæculórum. Amen."
        )); bead += 1
        
        // Fatima Prayer
        steps.append(RosaryBeadStep(beadNumber: bead, title: "Fatima Prayer",
            english: "O my Jesus, forgive us our sins, save us from the fires of hell, lead all souls to Heaven, especially those most in need of Thy mercy.",
            latin: "Domine Iesu, dimitte nobis debita nostra, libera nos ab igne inferni, conduc in caelum omnes animas, praesertim eas quae misericordiae tuae maxime indigent.")); bead += 1

        // Mysteries
        for mystery in data.mysteries {
            steps.append(RosaryBeadStep(
                beadNumber: bead, title: mystery.title,
                english: """
Our Father, who art in heaven, hallowed be Thy name;
Thy kingdom come; Thy will be done on earth as it is in heaven.
Give us this day our daily bread;
and forgive us our trespasses,
as we forgive those who trespass against us;
and lead us not into temptation, but deliver us from evil. Amen.
""",
                latin: """
Pater noster, qui es in cælis, sanctificétur nomen tuum.
Advéniat regnum tuum. Fiat voluntas tua, sicut in cælo, et in terra.
Panem nostrum cotidiánum da nobis hódie,
et dimítte nobis débita nostra sicut et nos dimíttimus debitóribus nostris.
Et ne nos indúcas in tentatiónem, sed líbera nos a malo. Amen.
"""
            )); bead += 1

            for i in 1...10 {
                let verse = mystery.verses.first
                let english = """
                \(verse?.english ?? "")\n
                Hail Mary, full of grace, the Lord is with thee.
                Blessed art thou among women,
                and blessed is the fruit of thy womb, Jesus.
                Holy Mary, Mother of God,
                pray for us sinners,
                now and at the hour of our death. Amen.
                """

                let latin = """
                \(verse?.latin ?? "")\n
                Ave Maria, gratia plena, Dominus tecum.
                Benedicta tu in mulieribus,
                et benedictus fructus ventris tui, Iesus.
                Sancta Maria, Mater Dei,
                ora pro nobis peccatoribus,
                nunc et in hora mortis nostrae. Amen.
                """

                steps.append(RosaryBeadStep(beadNumber: bead, title: "Hail Mary \(i)", english: english, latin: latin))
                bead += 1
            }

            steps.append(RosaryBeadStep(
                beadNumber: bead, title: "Glory Be",
                english: "Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.",
                latin: "Glória Patri, et Fílio, et Spirítui Sancto. Sicut erat in princípio, et nunc, et semper, et in sǽcula sæculórum. Amen."
            )); bead += 1

            steps.append(RosaryBeadStep(
                beadNumber: bead, title: "Fatima Prayer",
                english: "O my Jesus, forgive us our sins, save us from the fires of hell; lead all souls to Heaven, especially those most in need of Thy mercy.",
                latin: "Domine Iesu, dimitte nobis debita nostra, libera nos ab igne inferni, perduc in caelum omnes animas, praesertim eas quae misericordiae tuae maxime indigent."
            )); bead += 1
        }

        return steps
    }
}
