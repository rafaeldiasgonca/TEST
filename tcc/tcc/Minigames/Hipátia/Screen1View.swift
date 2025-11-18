// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen1View.swift
// View para o Minigame 1 (MVVM)

import SwiftUI

struct Screen1View: View {
    @StateObject private var viewModel = Screen1ViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Minigame 1")
                .font(.title)
                .fontWeight(.semibold)

            Text("Status: \(viewModel.status)")
                .foregroundColor(.secondary)

            Text("Score: \(viewModel.score)")
                .font(.headline)

            HStack(spacing: 12) {
                Button("Start") {
                    viewModel.start()
                }
                .buttonStyle(.borderedProminent)

                Button("+1") {
                    viewModel.incrementScore()
                }
                .buttonStyle(.bordered)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Minigame 1")
    }
}
