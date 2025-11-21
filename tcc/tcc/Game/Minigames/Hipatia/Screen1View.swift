import SwiftUI
import Combine

struct Screen1View: View {
    @StateObject private var viewModel = Screen1ViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                ZStack {
                    Image("lousa")
                        .resizable()
                        .scaledToFit()
                    equationTextView
                }
                .padding()

                VStack(spacing: 20) {
                    HStack(spacing: 37) {
                        keyButton(imageName: "tecla1") { viewModel.tapDigit(1) }
                        keyButton(imageName: "tecla2") { viewModel.tapDigit(2) }
                        keyButton(imageName: "tecla3") { viewModel.tapDigit(3) }
                    }

                    HStack(spacing: 37) {
                        keyButton(imageName: "tecla4") { viewModel.tapDigit(4) }
                        keyButton(imageName: "tecla5") { viewModel.tapDigit(5) }
                        keyButton(imageName: "tecla6") { viewModel.tapDigit(6) }
                    }

                    HStack(spacing: 37) {
                        keyButton(imageName: "tecla7") { viewModel.tapDigit(7) }
                        keyButton(imageName: "tecla8") { viewModel.tapDigit(8) }
                        keyButton(imageName: "tecla9") { viewModel.tapDigit(9) }
                    }

                    HStack(spacing: 37) {
                        keyButton(imageName: "tecla0") { viewModel.tapDigit(0) }

                        keyButton(imageName: "deleteButton") {
                            viewModel.deleteLast()
                        }

                        keyButton(imageName: "confirmButton") {
                            viewModel.confirm()
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(
            Image("hipatiaCuted")
                .resizable()
                .scaledToFit()
                .frame(width: 160)
                .offset(x: -1, y: -30)
                .allowsHitTesting(false)
                .ignoresSafeArea(),
            alignment: .bottomLeading
        )
        .clipped()
        .padding()
        .background(Color.white)
        .alert("Ops!", isPresented: $viewModel.showErrorAlert) {
            Button("Tentar de novo", role: .cancel) { }
        } message: {
            Text("Resposta incorreta, tente novamente! 😊")
        }
    }

    // MARK: - Helper

    private func keyButton(imageName: String,
                           action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 79, height: 72)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Equação com cor apenas no Y (palpite)

    private var equationTextView: some View {
        (
            Text("\(viewModel.x) + ")
                .foregroundColor(.black)
            +
            Text(viewModel.guessText)
                .foregroundColor(Color(hex: "#DED551"))
            +
            Text(" = \(viewModel.z)")
                .foregroundColor(.black)
        )
        .font(.custom("LazySunday", size: 48))
    }
}

#Preview("Portrait") {
    Screen1View()
}
