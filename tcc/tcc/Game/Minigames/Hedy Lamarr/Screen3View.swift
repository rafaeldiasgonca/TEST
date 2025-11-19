// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen3View.swift
// View para o Minigame 3 (MVVM)

import SwiftUI

struct Screen3View: View {
    @StateObject private var viewModel = Screen3ViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Text("Minigame 3")
                .font(.title)
                .fontWeight(.semibold)

            Text("Counter: \(viewModel.counter)")
                .font(.headline)

            Button("Increase") {
                viewModel.increase()
            }
            .buttonStyle(.borderedProminent)

            Button("Reset") {
                viewModel.reset()
            }
            .buttonStyle(.bordered)

            Spacer()
        }
        .padding()
        .navigationTitle("Minigame 3")
    }
}
