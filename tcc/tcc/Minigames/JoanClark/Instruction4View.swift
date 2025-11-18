import SwiftUI

struct Instruction4View: View {
    @StateObject private var viewModel = Instruction4ViewModel()
    @Environment(\.dismiss) private var dismiss
    var onContinue: (() -> Void)?

    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.semibold)

            Text(viewModel.instructions)
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
                .padding()

            Spacer()

            HStack {
                Button("Voltar") {
                    dismiss()
                }
                .buttonStyle(.bordered)

                Spacer()

                Button("Continuar") {
                    onContinue?()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.horizontal)
        }
        .padding()
        .navigationTitle("Instruções")
    }
}
