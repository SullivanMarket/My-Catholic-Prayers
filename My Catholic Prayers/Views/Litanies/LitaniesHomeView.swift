//
//  LitaniesHomeView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/5/25.
//

import SwiftUI

struct LitaniesHomeView: View {
    @State private var selectedLitany: LitanyModel?
    private let categories: [LitanyCategory] = LitanyLoader.loadLitanyCategories()

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(categories) { category in
                    Section(header:
                        Text(category.category)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                    ) {
                        ForEach(category.litanies, id: \.id) { litanySummary in
                            Button(action: {
                                if let loaded = LitanyLoader.loadLitanyDetail(by: litanySummary.id) {
                                    selectedLitany = loaded
                                }
                            }) {
                                Text(litanySummary.title)
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color.accentColor)
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listRowBackground(Color.clear)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Litanies")
        } detail: {
            if let litany = selectedLitany {
                LitanyDetailView(litany: litany)
            } else {
                Text("Select a litany to view")
                    .foregroundColor(.secondary)
                    .italic()
                    .padding()
            }
        }
    }
}
