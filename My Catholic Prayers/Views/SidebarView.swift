
//
//  SidebarView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/4/25.
//

import SwiftUI

struct SidebarView: View {
    let psalms: [CatholicPsalm]
    let litanyCategories: [LitanyCategory]
    @Binding var selectedPsalm: CatholicPsalm?
    @Binding var selection: NavigationSection?
    @State private var showingSettings = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 50)

            List(selection: $selection) {
                Section {
                    sidebarButton(label: "Home", systemImage: "house", value: .home)
                    sidebarButton(label: "Psalms", systemImage: "book.closed", value: .psalmsHome)
                    sidebarButton(label: "Litanies", systemImage: "text.badge.plus", value: .litaniesHome)
                    sidebarButton(label: "Novenas", systemImage: "calendar", value: .novenasHome)
                    sidebarButton(label: "Stations", systemImage: "cross.case", value: .stations)
                    sidebarButton(label: "The Holy Rosary", systemImage: "circle.grid.cross", value: .rosaryHome)
                    sidebarButton(label: "The Divine Mercy Chaplet", systemImage: "heart", value: .divineMercy)
                    sidebarButton(label: "General Prayers", systemImage: "book", value: .rosaryPrayers)
                    sidebarButton(label: "Favorites", systemImage: "heart", value: .favorites)
                }
            }
            .listStyle(.sidebar)
            .scrollContentBackground(.hidden)
            .background(Color("SidebarBackground"))

            Spacer()

            // App Icon above Settings button
            Image("AppIconSidebar", bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //.frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.bottom, 8)

            Button(action: { showingSettings.toggle() }) {
                Label("Settings", systemImage: "gearshape")
                    .font(.headline)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(0)
            }
            .buttonStyle(.plain)
            .frame(height: 50)
            .sheet(isPresented: $showingSettings) {
                SettingsPopupView()
            }
        }
        .background(Color("SidebarBackground"))
        .ignoresSafeArea()
    }

    @ViewBuilder
    private func sidebarButton(label: String, systemImage: String, value: NavigationSection) -> some View {
        Button {
            selection = value
        } label: {
            Label(label, systemImage: systemImage)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .background(
                    selection == value ? Color.accentColor.opacity(0.25) : Color.clear
                )
                .foregroundColor(selection == value ? .accentColor : .primary)
                .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}
