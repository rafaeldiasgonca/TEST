//
//  ContentView.swift
//  tcc
//
//  Created by Rafael Dias Gonçalves on 13/11/25.
//

import SwiftUI

struct ContentView: View {
    enum Route: Hashable {
        case playMenu
        case instruction1
        case instruction2
        case instruction3
        case instruction4
        case game1
        case game2
        case game3
        case game4
    }

    @State private var path: [Route] = []

    var body: some View {
        NavigationStack(path: $path) {
            GeometryReader { geometry in

                VStack(spacing: 0) {
                    // Imagem responsiva no topo
                    Image("titleImage")
                        .padding(20)

                    // Primeira tela: apenas o botão "Jogar"
                    VStack(spacing: 24) {
                        Spacer()

                        Button("Começar") {
                            path.append(.playMenu)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        .frame(maxWidth: 220)
                        .font(.custom("LazySunday", size: 24))
                        .tint(Color(hex: "#1893BA"))



                        Spacer()
                        Image("menuSymbols")


                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .padding()
                }

            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .playMenu:
                    PlayMenuView(
                        onInstruction1: { path.append(.instruction1) },
                        onInstruction2: { path.append(.instruction2) },
                        onInstruction3: { path.append(.instruction3) },
                        onInstruction4: { path.append(.instruction4) }
                    )
                case .instruction1:
                    Instruction1View {
                        path.append(.game1)
                    }
                case .instruction2:
                    Instruction2View {
                        path.append(.game2)
                    }
                case .instruction3:
                    Instruction3View {
                        path.append(.game3)
                    }
                case .instruction4:
                    Instruction4View {
                        path.append(.game4)
                    }
                case .game1:
                    Screen1View()
                case .game2:
                    Screen2View()
                case .game3:
                    Screen3View()
                case .game4:
                    Screen4View()
                }
            }
        }
    }
}

#Preview("Portrait") {
    ContentView()
}

#Preview("Landscape Left", traits: .landscapeLeft) {
    ContentView()
}

#Preview("Landscape Right", traits: .landscapeRight) {
    ContentView()
}
