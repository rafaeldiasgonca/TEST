import SwiftUI

struct GameOverView: View {
    let score: Int
    let onReplay: () -> Void
    let onBackToMenu: () -> Void

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            Text("Fim de Jogo")
                .font(.custom("LazySunday", size: 64))
                .foregroundColor(.black)
            Text("Pontuação: \(score)")
                .font(.custom("LazySunday", size: 28))
                .foregroundColor(.black.opacity(0.7))
            VStack(spacing: 20) {
                Button(action: onReplay) {
                    Text("Jogar novamente")
                        .font(.custom("LazySunday", size: 22))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color(hex: "#8093CA")))
                        .foregroundColor(.white)
                }
                Button(action: onBackToMenu) {
                    Text("Voltar ao menu")
                        .font(.custom("LazySunday", size: 22))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Color(hex: "#DED551")))
                        .foregroundColor(.black)
                }
            }
            .frame(maxWidth: 320)
            Spacer()
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }
}

#Preview("Game Over") {
    GameOverView(score: 120, onReplay: {}, onBackToMenu: {})
}
