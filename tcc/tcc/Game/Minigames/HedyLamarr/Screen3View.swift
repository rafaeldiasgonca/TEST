// swift
import SwiftUI

struct Screen3View: View {
    @StateObject private var viewModel = Screen3ViewModel()
    @State private var activeKeyIndices: Set<Int> = []
    // Partículas de notas em animação
    @State private var particles: [NoteParticle] = []

    private let paintedKeys = ["teclaCpintada","teclaDpintada","teclaEpintada","teclaFpintada","teclaGpintada","teclaApintada","teclaBpintada"]
    private let normalKeys = ["teclaC","teclaD","teclaE","teclaF","teclaG","teclaA","teclaB"]
    private let noteImages = ["notaC","notaD","notaE","notaF","notaG","notaA","notaB"]

    var body: some View {
        GeometryReader { geo in
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
                                    play: { viewModel.playKey(at: index); spawnNote(for: index) },
                                    stop: { viewModel.stopKey(at: index) }
                                ))
                                .accessibilityLabel(Text("Tecla \(index + 1)"))
                            }
                        }
                    }
                }
                .padding()

                // Camada de partículas flutuantes
                ForEach(particles) { particle in
                    FloatingNoteView(imageName: particle.imageName) {
                        particles.removeAll { $0.id == particle.id }
                    }
                    .frame(width: 48, height: 48)
                    .position(x: xPosition(for: particle.keyIndex, in: geo.size), y: geo.size.height * 0.28)
                }
            }
        }
        .onAppear { viewModel.prepareAudio() }
    }

    // Calcula posição X aproximada da nota baseado no índice da tecla
    private func xPosition(for index: Int, in size: CGSize) -> CGFloat {
        let pianoWidth = size.width - 32 // margem aproximada
        let segment = pianoWidth / CGFloat(normalKeys.count)
        return (segment * CGFloat(index)) + segment/2 + 16
    }

    private func spawnNote(for index: Int) {
        guard index < noteImages.count else { return }
        let particle = NoteParticle(keyIndex: index, imageName: noteImages[index])
        particles.append(particle)
    }
}

// Modelo da partícula
struct NoteParticle: Identifiable {
    let id = UUID()
    let keyIndex: Int
    let imageName: String
}

// View da nota que anima e remove-se
struct FloatingNoteView: View {
    let imageName: String
    let onRemove: () -> Void
    @State private var animate = false

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .shadow(color: .black.opacity(0.25), radius: 4, y: 2)
            .opacity(animate ? 0 : 1)
            .offset(y: animate ? -140 : 0)
            .onAppear {
                withAnimation(.easeOut(duration: 1.2)) {
                    animate = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                    onRemove()
                }
            }
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
