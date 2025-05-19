//
//  ContentView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: NavigationSection? = .home
    @State private var selectedPsalm: CatholicPsalm? = nil
    @State private var selectedLitany: LitanyModel? = nil

    let psalms = CatholicPsalmLoader.loadPsalms()
    let litanies = LitanyLoader.loadLitanyCategories()
    let novenaSummaries = NovenaLoader.loadNovenaSummaries()

    var body: some View {
        NavigationSplitView {
            SidebarView(
                psalms: psalms,
                litanyCategories: litanies,
                selectedPsalm: $selectedPsalm,
                selection: $selection
            )
            .frame(minWidth: 250, idealWidth: 300, maxWidth: 400)
        } detail: {
            NavigationStack {
                Group {
                    switch selection {
                    case .home:
                        HomeView()

                    case .psalmsHome:
                        PsalmsHomeView(psalms: psalms, selection: $selection)

                    case .psalm(let psalm):
                        PsalmDetailView(psalm: psalm)

                    case .litaniesHome:
                        LitaniesHomeView()

                    case .litany(let summary):
                        if let loaded = LitanyLoader.loadLitanyDetail(by: summary.id) {
                            LitanyDetailView(litany: loaded)
                        } else {
                            Text("⚠️ Could not load litany with id: \(summary.id)")
                                .foregroundColor(.red)
                                .padding()
                        }

                    case .novenasHome:
                        NovenasHomeView(novenas: novenaSummaries, selection: $selection)

                    case .novena(let summary):
                        if let loaded = NovenaLoader.loadNovenaDetail(by: summary.id) {
                            NovenaDetailView(novena: loaded)
                        } else {
                            Text("⚠️ Could not load novena with id: \(summary.id)")
                                .foregroundColor(.red)
                                .padding()
                        }

                    case .favorites:
                        FavoritesPage(
                            allPsalms: psalms,
                            allLitanies: LitanyLoader.loadAllLitanies(),
                            allNovenaSummaries: novenaSummaries,
                            selection: $selection
                        )

                    case .stations:
                        StationsHomeView()

                    case .rosaryHome:
                        RosaryHomeView(selection: $selection)

                    case .rosaryPrayers:
                        RosaryPrayersView()

                    case .rosary(let section):
                        RosaryDetailView(section: section)

                    case .divineMercy:
                        DivineMercyChapletView()

                    case nil:
                        Text("Select an item from the sidebar.")
                            .italic()
                    }
                }
                // ✅ Must be inside NavigationStack to compile correctly
                .navigationDestination(for: NavigationSection.self) { section in
                    switch section {
                    case .rosary(let section):
                        RosaryDetailView(section: section)
                    default:
                        EmptyView()
                    }
                }
            }
        }
        .preferredColorScheme(AppSettings.shared.colorScheme)
    }
}
