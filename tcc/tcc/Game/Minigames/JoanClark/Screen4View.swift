// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen4View.swift
// View para o Minigame 4 (MVVM)

import SwiftUI

struct Screen4View: View {
    @StateObject private var viewModel = Screen4ViewModel()
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 16) {
            Text("Minigame 4")
                .font(.title)
                .fontWeight(.semibold)

            Text(viewModel.text)
                .foregroundColor(.secondary)

            TextField("Digite algo", text: $inputText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)

            Button("Atualizar") {
                viewModel.updateText(inputText)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
        .background(Color(.white))
    }
}
