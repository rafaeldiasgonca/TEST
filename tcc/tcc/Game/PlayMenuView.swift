import SwiftUI

struct PlayMenuView: View {
    var onInstruction1: () -> Void
    var onInstruction2: () -> Void
    var onInstruction3: () -> Void
    var onInstruction4: () -> Void

    var body: some View {
        GeometryReader { geometry in
            let isLandscape = geometry.size.width > geometry.size.height

            VStack(spacing: 16) {
                Text("Escolha seu livro!")
                    .font(.custom("LazySunday", size: 24))
                    .fontWeight(.semibold)

                ScrollView() {

                    Image("livro1")

                    Button("Hipátia") {
                        onInstruction1()
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)
                    .frame(maxWidth: 220)
                    .tint(Color(hex: "#DED551"))
                    .font(.custom("LazySunday", size: 24))
                    Spacer()

                    Image("livro2")
                    Button("Ada Lovelace") {
                        onInstruction2()
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)
                    .frame(maxWidth: 220)
                    .tint(Color(hex: "E1AEE0"))
                    .font(.custom("LazySunday", size: 24))
                    Spacer()

                    Image("livro3")
                    Button("Hedy Lamarr") {
                        onInstruction3()
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)
                    .frame(maxWidth: 220)
                    .tint(Color(hex: "8093CA"))
                    .font(.custom("LazySunday", size: 24))
                    Spacer()

                    Image("livro4")
                    Button("Joan Clarke") {
                        onInstruction4()
                    }
                    .buttonStyle(.glass)
                    .controlSize(.large)
                    .frame(maxWidth: 220)
                    .tint(Color(hex: "C49461"))
                    .font(.custom("LazySunday", size: 24))
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: isLandscape ? .trailing : .center)
                .padding(.trailing, isLandscape ? max(geometry.safeAreaInsets.trailing, 24) : 0)
                .scrollIndicators(.hidden)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationTitle("Jogar")
    }
}

// Previews para PlayMenuView
struct PlayMenuView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PlayMenuView(onInstruction1: {}, onInstruction2: {}, onInstruction3: {}, onInstruction4: {})
                .previewDisplayName("Portrait")

            PlayMenuView(onInstruction1: {}, onInstruction2: {}, onInstruction3: {}, onInstruction4: {})
                .previewDisplayName("Landscape Left")
                .previewInterfaceOrientation(.landscapeLeft)

            PlayMenuView(onInstruction1: {}, onInstruction2: {}, onInstruction3: {}, onInstruction4: {})
                .previewDisplayName("Landscape Right")
                .previewInterfaceOrientation(.landscapeRight)
        }
    }
}
