//
//  NovenasHomeView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/8/25.
//

import SwiftUI

struct NovenasHomeView: View {
    let novenas: [NovenaSummary]
    @Binding var selection: NavigationSection?

    // Two flexible columns
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("📅 Novenas")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top)

                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(novenas) { novena in
                        Button(action: {
                            selection = .novena(novena)
                        }) {
                            Text(novena.title)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.vertical, 10)
                                .padding(.horizontal, 16)
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                Spacer()
            }
            .padding()
        }
        .background(Color("MainBackground").ignoresSafeArea())
        .navigationTitle("My Catholic Prayers")
    }
}
