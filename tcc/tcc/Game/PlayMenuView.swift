
import SwiftUI

struct PlayMenuView: View {
    var onInstruction1: () -> Void
    var onInstruction2: () -> Void
    var onInstruction3: () -> Void
    var onInstruction4: () -> Void

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height

            VStack(spacing: 24) {
                Text("Escolha seu livro!")
                    .font(.custom("LazySunday", size: 28))
                    .fontWeight(.semibold)

                ScrollView {
                    bookBlock(
                        image: "livro1",
                        title: "Hipátia",
                        color: Color(hex: "#DED551"),
                        action: onInstruction1
                    )

                    bookBlock(
                        image: "livro2",
                        title: "Ada Lovelace",
                        color: Color(hex: "#E1AEE0"),
                        action: onInstruction2
                    )

                    bookBlock(
                        image: "livro3",
                        title: "Hedy Lamarr",
                        color: Color(hex: "#8093CA"),
                        action: onInstruction3
                    )

                    bookBlock(
                        image: "livro4",
                        title: "Joan Clarke",
                        color: Color(hex: "#C49461"),
                        action: onInstruction4
                    )
                }
                .scrollIndicators(.hidden)
                .frame(maxWidth: .infinity, alignment: isLandscape ? .trailing : .center)
                .padding(.trailing, isLandscape ? max(geometry.safeAreaInsets.trailing, 24) : 0)

                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .background(Color.white.ignoresSafeArea())
    }

    @ViewBuilder
    private func bookBlock(image: String, title: String, color: Color, action: @escaping () -> Void) -> some View {
        VStack(spacing: 12) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 240)

            Button(action: action) {
                Text(title)
                    .font(.custom("LazySunday", size: 22))
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(ColoredBookButtonStyle(background: color))
            .frame(maxWidth: 240)
        }
    }
}

struct ColoredBookButtonStyle: ButtonStyle {
    let background: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(background.opacity(configuration.isPressed ? 0.75 : 1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color.black.opacity(0.08), lineWidth: 1)
            )
            .foregroundColor(.black)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
            .shadow(color: Color.black.opacity(0.08), radius: 4, y: 2)
    }
}
