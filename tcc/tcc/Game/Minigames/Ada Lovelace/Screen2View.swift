// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen2View.swift
// View para o Minigame 2 (MVVM)

import SwiftUI

struct Screen2View: View {
    @StateObject private var viewModel = Screen2ViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Minigame 2")
                .font(.title)
                .fontWeight(.semibold)

            Text(viewModel.message)
                .foregroundColor(.secondary)

            Button("Começar") {
                viewModel.begin()
            }
            .buttonStyle(.borderedProminent)

            Button("Reset") {
                viewModel.reset()
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .background(Color(.white))
    }
}
