//
//  ExaminationChecklistView.swift
//  My Catholic Prayers
//
//  Created by Sean Sullivan on 5/23/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ExaminationChecklistView: View {
    let framework: ExaminationFramework
    let role: ExaminationRole
    @State private var examination = Examination(
        framework: "",
        role: "",
        sections: []
    )

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("Examin of Conscience: \(framework.displayName) (\(role.displayName))")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: exportExamination) {
                    Label("Export Examin", systemImage: "square.and.arrow.up")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)

            if !examination.sections.isEmpty {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(examination.sections.indices, id: \.self) { sectionIndex in
                            let section = examination.sections[sectionIndex]
                            VStack(alignment: .leading, spacing: 10) {
                                Text(section.title)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.primary)

                                ForEach(section.questions.indices, id: \.self) { questionIndex in
                                    let question = section.questions[questionIndex]
                                    Toggle(isOn: toggleBinding(for: sectionIndex, questionIndex: questionIndex)) {
                                        Text(question.text)
                                            .font(.custom("Snell Roundhand", size: 25))
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                            .padding()
                            .background(Color(NSColor.controlBackgroundColor))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                }
            } else {
                Text("⚠️ Unable to load examination.")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding(.bottom)
        .navigationTitle("My Catholic Prayers")
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button(action: {
                    dismiss()
                }) {
                    Label("Back", systemImage: "arrow.uturn.backward.circle")
                        .labelStyle(.titleAndIcon)
                        .foregroundColor(.primary)
                        .font(.title2)
                }
            }
        }
        .onAppear {
            if let loaded = ExaminationLoader.loadExamination(framework: framework, role: role) {
                self.examination = loaded
            }
        }
    }

    private func toggleBinding(for sectionIndex: Int, questionIndex: Int) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                examination.sections[sectionIndex].questions[questionIndex].checked
            },
            set: { newValue in
                examination.sections[sectionIndex].questions[questionIndex].checked = newValue
            }
        )
    }

    private func exportExamination() {
        let header = """
        Examin of Conscience
        Framework: \(framework.displayName)
        Role: \(role.displayName)

        =======================================================
        """

        let body = examination.sections.map { section in
            let sectionTitle = "Section: \(section.title)"
            let questions = section.questions.map { q in
                let check = q.checked ? "[✔]" : "[ ]"
                return "\(check) \(q.text)"
            }.joined(separator: "\n")

            return "\(sectionTitle)\n\n\(questions)\n\n----------------------------------------------------------------"
        }.joined(separator: "\n\n")

        let fullText = header + "\n\n" + body

        let panel = NSSavePanel()
        panel.title = "Save Examination Report"
        panel.allowedContentTypes = [.plainText]
        panel.nameFieldStringValue = "Examination.txt"

        if panel.runModal() == .OK, let url = panel.url {
            try? fullText.write(to: url, atomically: true, encoding: .utf8)
        }
    }
}
