//
//  StationsHomeView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/13/25.
//

import SwiftUI

struct StationsHomeView: View {
    @State private var currentPage = 0

    // Images: first 2 are full width, next 14 have left artwork and right text
    private let contentImageNames: [String] = [
        "stations_home", "intro"
    ] + (1...14).map { String(format: "station_%d", $0) }

    private let artImageNames: [String?] = [
        nil, nil
    ] + (1...14).map { String(format: "marble_station_%02d", $0) }

    var body: some View {
        ZStack {
            Color("MainBackground").ignoresSafeArea()

            VStack(spacing: 16) {
                if currentPage <= 1 {
                    // Full-width pages
                    if let image = NSImage(named: contentImageNames[currentPage]) {
                        Image(nsImage: image)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                            .shadow(radius: 4)
                            .padding()
                    } else {
                        missingImageLabel(name: contentImageNames[currentPage])
                    }
                } else {
                    HStack(spacing: 16) {
                        if let leftName = artImageNames[currentPage],
                           let artImage = NSImage(named: leftName) {
                            Image(nsImage: artImage)
                                .resizable()
                                .interpolation(.high)
                                .scaledToFit()
                                .frame(maxHeight: 1500)
                                .cornerRadius(10)
                                .shadow(radius: 2)
                                .drawingGroup()
                        } else {
                            missingImageLabel(name: artImageNames[currentPage] ?? "missing")
                                .frame(maxWidth: 300)
                        }

                        if let rightImage = NSImage(named: contentImageNames[currentPage]) {
                            Image(nsImage: rightImage)
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        } else {
                            missingImageLabel(name: contentImageNames[currentPage])
                        }
                    }
                    .padding(.horizontal)
                }

                // Navigation buttons
                HStack {
                    Button {
                        if currentPage > 0 { currentPage -= 1 }
                    } label: {
                        Label("Previous", systemImage: "arrow.left")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .frame(minWidth: 140)
                            .foregroundColor(.white)
                            .background(currentPage > 0 ? Color.accentColor : Color.gray.opacity(0.4))
                            .clipShape(Capsule())
                    }
                    .disabled(currentPage == 0)
                    .buttonStyle(PlainButtonStyle()) // ✅ Prevents outer box

                    Spacer()

                    Button {
                        if currentPage < contentImageNames.count - 1 { currentPage += 1 }
                    } label: {
                        Label("Next", systemImage: "arrow.right")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .frame(minWidth: 140)
                            .foregroundColor(.white)
                            .background(currentPage < contentImageNames.count - 1 ? Color.accentColor : Color.gray.opacity(0.4))
                            .clipShape(Capsule())
                    }
                    .disabled(currentPage == contentImageNames.count - 1)
                    .buttonStyle(PlainButtonStyle()) // ✅ Match pill buttons
                }
                .padding(.horizontal)
                .padding(.bottom, 12)
            }
        }
        .frame(minWidth: 700, minHeight: 600)
    }

    @ViewBuilder
    private func missingImageLabel(name: String) -> some View {
        Text("🚫 Image not found: \(name)")
            .foregroundColor(.red)
            .italic()
    }
}

#Preview {
    StationsHomeView()
}
