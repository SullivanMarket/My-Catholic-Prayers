//
//  PsalmsHomeView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import SwiftUI

struct PsalmsHomeView: View {
    let psalms: [CatholicPsalm]
    @Binding var selection: NavigationSection?

    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Praying the Psalms")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 10)

                    Text("Select a Psalm below to begin prayer and reflection.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Divider()

                    let columns = stride(from: 0, to: psalms.count, by: 25).map {
                        Array(psalms.dropFirst($0).prefix(25))
                    }

                    HStack(alignment: .top, spacing: 40) {
                        ForEach(columns.indices, id: \.self) { columnIndex in
                            VStack(alignment: .leading, spacing: 8) {
                                ForEach(columns[columnIndex]) { psalm in
                                    Button(action: {
                                        selection = nil
                                        DispatchQueue.main.async {
                                            selection = .psalm(psalm)
                                        }
                                    }) {
                                        Text("Psalm \(psalm.number)")
                                            .font(.system(size: 18, weight: .semibold))
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 8)
                                            //.background(Color.blue.opacity(0.8))
                                            .background(Color.accentColor)
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}
