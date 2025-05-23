//
//  ExaminationSelectorView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/23/25.
//

import SwiftUI

struct ExaminationSelectorView: View {
    @State private var selectedFramework: ExaminationFramework = .tenCommandments
    @State private var selectedRole: ExaminationRole = .adult
    @State private var navigateToChecklist = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Examination of Conscience")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.black)

            Text("Select your framework and role to begin.")
                .font(.title3)
                .foregroundColor(.black)

            Form {
                Picker("Framework", selection: $selectedFramework) {
                    ForEach(ExaminationFramework.allCases, id: \.self) { framework in
                        Text(framework.displayName)
                    }
                }
                .font(.title2)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(NSColor.controlBackgroundColor))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                //.foregroundColor(.black)

                Picker("Role", selection: $selectedRole) {
                    ForEach(ExaminationRole.allCases, id: \.self) { role in
                        Text(role.displayName)
                    }
                }
                .font(.title2)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(NSColor.controlBackgroundColor))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                //.foregroundColor(.black)

                Button {
                    navigateToChecklist = true
                } label: {
                    Label("Begin Examination", systemImage: "arrow.right.circle.fill")
                        .font(.title2)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 14)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top)
            }
            .frame(maxWidth: 500)
            .padding()

            Image("confession")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 900)
                .padding(.top, 20)

            Spacer()
        }
        .padding()
        .background(Color("Background"))
        .navigationDestination(isPresented: $navigateToChecklist) {
            ExaminationChecklistView(
                framework: selectedFramework,
                role: selectedRole
            )
        }
    }
}
