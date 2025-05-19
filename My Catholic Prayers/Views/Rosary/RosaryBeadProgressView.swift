//
//  RosaryBeadProgressView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/14/25.
//

import SwiftUI

struct RosaryBeadProgressView: View {
    @Binding var currentBead: Int
    let totalBeads: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalBeads, id: \.self) { index in
                Circle()
                    .fill(index == currentBead ? Color.accentColor : Color.gray.opacity(0.4))
                    .frame(width: 16, height: 16)
                    .onTapGesture {
                        currentBead = index
                    }
                    .animation(.easeInOut(duration: 0.2), value: currentBead)
            }
        }
        .padding()
    }
}
