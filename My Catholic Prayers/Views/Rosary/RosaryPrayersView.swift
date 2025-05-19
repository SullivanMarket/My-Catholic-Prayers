//
//  RosaryPrayersView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import SwiftUI

struct RosaryPrayersView: View {
    @AppStorage("useLatin") private var useLatin: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("General Prayers")
                    .font(.title)
                    .bold()
                    .padding(.top)

                Toggle(isOn: $useLatin) {
                    Text("Show Latin")
                        .font(.headline)
                }
                .toggleStyle(SwitchToggleStyle())
                .padding(.bottom)

                ForEach(rosaryPrayers) { prayer in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(prayer.title)
                            .font(.title3)
                            .bold()

                        Text(useLatin ? prayer.latin : prayer.english)
                            .font(.custom("Snell Roundhand", size: 28))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                    )
                }

                Spacer()
            }
            .padding(.horizontal)
        }
        .navigationTitle("My Catholic Prayers")
    }
}
