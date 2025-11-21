// swift
import SwiftUI

struct Screen3View: View {
    @StateObject private var viewModel = Screen3ViewModel()
    @State private var activeKeyIndices: Set<Int> = []

    private let paintedKeys = [
        "teclaCpintada","teclaDpintada","teclaEpintada","teclaFpintada","teclaGpintada","teclaApintada","teclaBpintada"
    ]
    private let normalKeys = [
        "teclaC","teclaD","teclaE","teclaF","teclaG","teclaA","teclaB"
    ]

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 16) {
                Image("piano")
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(Array(paintedKeys.enumerated()), id: \.offset) { index, imageName in
                            Image(imageName)
                                .opacity(activeKeyIndices.contains(index) ? 1 : 0)
                        }
                    }
                    HStack(spacing: 0) {
                        ForEach(Array(normalKeys.enumerated()), id: \.offset) { index, imageName in
                            Button(action: {}) {
                                Image(imageName)
                            }
                            .buttonStyle(PaintedKeyButtonStyle(
                                index: index,
                                activeKeyIndices: $activeKeyIndices,
                                play: { viewModel.playKey(at: index) },
                                stop: { viewModel.stopKey(at: index) }
                            ))
                            .accessibilityLabel(Text("Tecla \(index + 1)"))
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear { viewModel.prepareAudio() }
    }
}

struct PaintedKeyButtonStyle: ButtonStyle {
    let index: Int
    @Binding var activeKeyIndices: Set<Int>
    let play: () -> Void
    let stop: () -> Void

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { _, isPressed in
                if isPressed {
                    activeKeyIndices.insert(index)
                    play()
                } else {
                    activeKeyIndices.remove(index)
                }
            }
    }
}
