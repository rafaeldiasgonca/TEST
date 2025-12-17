import Foundation
import Combine
import SwiftUI

struct Screen4View: View {
    @StateObject private var viewModel = Screen4ViewModel()
    @State private var alertText: String = ""

    var body: some View {
        ScrollView {
            headerSection
            slotsSection
            cipherSection
            keyboardSection
            feedbackSection
        }
        .padding()
        .background(Color.white)
        .scrollIndicators(.hidden)
        .onAppear { viewModel.startNewGame() }
        .onChange(of: viewModel.showResultAlert) { newValue in
            if newValue { alertText = viewModel.alertMessage }
        }
        .alert(isPresented: $viewModel.showResultAlert) {
            Alert(
                title: Text("Resultado"),
                message: Text(alertText),
                primaryButton: .default(Text("Novo Jogo")) {
                    viewModel.resetScore(); viewModel.startNewGame()
                },
                secondaryButton: .cancel(Text("Tentar novamente")) {
                    viewModel.resetScore()
                }
            )
        }
    }

    // MARK: - Sections

    private var headerSection: some View {
        ZStack(alignment: .topTrailing){
            Image("joanCuted")
                .padding(.trailing, 0)
                .ignoresSafeArea(edges: .trailing)
            VStack(alignment: .leading, spacing: 12) {
                ForEach(viewModel.displayedKeyPairs, id: \.0) { pair in
                    Text(String(pair.0) + " = " + String(pair.1))
                        .font(.custom("LazySunday", size: 40))
                        .foregroundColor(Color.black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 40)
        }
    }

    private var slotsSection: some View {
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
    }

    private var cipherSection: some View {
        Text(viewModel.cipherWord)
            .font(.custom("LazySunday", size: 32))
            .foregroundColor(Color(hex: "#C49461"))
            .padding(.bottom, 40)
    }

    private var keyboardSection: some View {
        VStack(spacing: 8) {
            letterRow(["a","b","c","d","e"])
            letterRow(["f","g","h","i","j"])
            letterRow(["k","l","m","n","o"])
            letterRow(["p","q","r","s","t"])
            letterRow(["u","v","w","x","y"])
            letterRow(["z", "deleteButtonMini", "confirmButtonMini"])
        }
    }

    private var feedbackSection: some View {
        Group {
            if viewModel.isGameOver {
                Text(viewModel.isWin ? "Você acertou!" : "Fim de jogo! Palavra: \(viewModel.secretWord)")
                    .font(.custom("LazySunday", size: 32))
                    .foregroundColor(viewModel.isWin ? .green : .red)
                    .padding(.top, 32)
            }
        }
    }

    // MARK: - Helpers

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
            return viewModel.userSlots.allSatisfy { $0 == nil }
        case "confirmButtonMini":
            return false
        default:
            return viewModel.isGameOver || viewModel.userSlots.allSatisfy { $0 != nil }
        }
    }
}

#Preview("Portrait") { Screen4View() }
