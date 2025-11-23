import Foundation
import Combine
import SwiftUI

struct Screen4View: View {
    @StateObject private var viewModel = Screen4ViewModel()

    var body: some View {

        ScrollView {
            ZStack(alignment: .topTrailing){
                Image("joanCuted")
                    .padding(.trailing, 0)
                    .ignoresSafeArea(edges: .trailing)
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
            }
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

            // Removido HStack com botões de texto Remover/Reiniciar
        }
        .padding()
        .background(Color.white)
        .scrollIndicators(.hidden)
        .onAppear { viewModel.startNewGame() }
        .alert(isPresented: $viewModel.showResultAlert) {
            if viewModel.lastAttemptCorrect == true {
                return Alert(title: Text("Correto!"), message: Text("Você decifrou a palavra."), dismissButton: .default(Text("Novo Jogo")) { viewModel.startNewGame() })
            } else {
                return Alert(title: Text("Errado"), message: Text("Tente novamente."), dismissButton: .default(Text("Fechar")) { viewModel.showResultAlert = false })
            }
        }
    }

    private func letterRow(_ assets: [String]) -> some View {
        HStack {
            ForEach(assets, id: \.self) { name in
                Button {
                    switch name {
                    case "deleteButtonMini":
                        viewModel.removeLast()
                    case "confirmButtonMini":
                        viewModel.confirmAttempt()
                    default:
                        if name.count == 1, let ch = name.uppercased().first {
                            viewModel.selectLetter(ch)
                        }
                    }
                } label: {
                    Image(name)
                        .opacity(disabledState(for: name) ? 0.4 : 1.0)
                }
                .disabled(disabledState(for: name))
            }
        }
    }

    private func disabledState(for name: String) -> Bool {
        switch name {
        case "deleteButtonMini":
            return viewModel.userSlots.allSatisfy { $0 == nil } // nada para remover
        case "confirmButtonMini":
            return false // sempre pode reiniciar
        default:
            // letras desabilitadas se jogo acabou ou todos os slots preenchidos
            return viewModel.isGameOver || viewModel.userSlots.allSatisfy { $0 != nil }
        }
    }
}

#Preview("Portrait") { Screen4View() }
