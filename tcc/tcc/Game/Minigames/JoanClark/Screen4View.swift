
import Foundation
import Combine
import SwiftUI

struct Screen4View: View {
    @StateObject private var viewModel = Screen4ViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.displayedKeyPairs, id: \.0) { pair in
                    Text("\(pair.0) = \(pair.1)")
                        .font(.custom("LazySunday", size: 40))
                        .foregroundColor(Color.black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 40)

            // Slots dinâmicos (mantém estilo de 10 underscores, mas mostra só até secretWord.count)
            HStack(spacing: 8) {
                ForEach(0..<max(viewModel.userSlots.count, 10), id: \.self) { i in
                    if i < viewModel.userSlots.count {
                        Text(viewModel.userSlots[i].map { String($0) } ?? "_")
                            .font(.custom("LazySunday", size: 40))
                            .foregroundColor(Color.black)
                    }
                }
            }
            .background(Color.white)
            .padding(.bottom, 40)

            // Palavra cifrada (opcional como feedback visual)
            Text(viewModel.cipherWord)
                .font(.custom("LazySunday", size: 32))
                .foregroundColor(Color(hex: "#C49461"))
                .padding(.bottom, 40)

            // Linhas de letras usando imagens (botões)
            letterRow(["a","b","c","d","e"])
            letterRow(["f","g","h","i","j"])
            letterRow(["k","l","m","n","o"])
            letterRow(["p","q","r","s","t"])
            letterRow(["u","v","w","x","y"])
            letterRow(["z", "deleteButtonMini", "confirmButtonMini"])

            // Feedback (mantém estilo simples)
            if viewModel.isGameOver {
                Text(viewModel.isWin ? "Você acertou!" : "Fim de jogo! Palavra: \(viewModel.secretWord)")
                    .font(.custom("LazySunday", size: 32))
                    .foregroundColor(viewModel.isWin ? .green : .red)
                    .padding(.top, 32)
            }

            // Controles (remover / novo jogo) mantendo layout simples
            HStack(spacing: 24) {
                Button("Remover") { viewModel.removeLast() }
                    .font(.custom("LazySunday", size: 28))
                    .foregroundColor(.black)
                    .disabled(viewModel.userSlots.allSatisfy { $0 == nil })

                Button(viewModel.isGameOver ? "Novo Jogo" : "Reiniciar") { viewModel.startNewGame() }
                    .font(.custom("LazySunday", size: 28))
                    .foregroundColor(Color(hex: "#8093CA"))
            }
            .padding(.top, 32)
            .padding(.bottom, 60)
        }
        .padding()
        .background(Color.white)
        .scrollIndicators(.hidden)
        .onAppear { viewModel.startNewGame() }
    }

    private func letterRow(_ assets: [String]) -> some View {
        HStack {
            ForEach(assets, id: \.self) { name in
                Button(action: { if let ch = name.uppercased().first { viewModel.selectLetter(ch) } }) {
                    Image(name)
                }
                .disabled(viewModel.isGameOver || viewModel.userSlots.allSatisfy { $0 != nil })
                .opacity(viewModel.isGameOver ? 0.5 : 1)
            }
        }
    }
}

#Preview("Portrait") { Screen4View() }
