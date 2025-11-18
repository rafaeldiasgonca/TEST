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
                Text("Escolha um minigame")
                    .font(.title2)
                    .fontWeight(.semibold)

                VStack(spacing: 12) {
                    Button("Minigame 1") {
                        onInstruction1()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .frame(maxWidth: 220)

                    Button("Minigame 2") {
                        onInstruction2()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .frame(maxWidth: 220)

                    Button("Minigame 3") {
                        onInstruction3()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .frame(maxWidth: 220)

                    Button("Minigame 4") {
                        onInstruction4()
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .frame(maxWidth: 220)
                }
                .frame(maxWidth: .infinity, alignment: isLandscape ? .trailing : .center)
                .padding(.trailing, isLandscape ? max(geometry.safeAreaInsets.trailing, 24) : 0)

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
