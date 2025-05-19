
//
//  LitaniesListView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import SwiftUI

struct LitaniesListView: View {
    let litanyCategories: [LitanyCategory]
    @Binding var selectedLitany: LitanyModel?

    var body: some View {
        List {
            ForEach(litanyCategories) { category in
                Section(header: Text(category.category).font(.headline)) {
                    let litanies: [LitanySummary] = category.litanies
                    ForEach(litanies, id: \.id) { litany in
                        Button {
                            if let loaded = LitanyLoader.loadLitanyDetail(by: litany.id) {
                                selectedLitany = loaded
                            }
                        } label: {
                            Text(litany.title)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
    }
}
