//
//  HomeView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color("MainBackground")
                .ignoresSafeArea()

            VStack(spacing: 30) {
                Image("madona-n-child")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 900)
                    .cornerRadius(16)
                    .shadow(radius: 10)

                Text("My Catholic Prayers")
                    .font(.custom("Snell Roundhand", size: 48))
                    .foregroundColor(.primary)

                Text("Welcome to your prayer companion.")
                    .font(.custom("Snell Roundhand", size: 28))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 40)
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 40)
        }
    }
}
