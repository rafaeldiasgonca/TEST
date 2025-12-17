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
        case ranking // new route
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

                        // Ranking button
                        Button("Ranking") {
                            path.append(.ranking)
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
            .background(Color.white)
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
                    InstructionView(
                        viewModel: InstructionViewModel(
                            title: "Hipátia",
                            subtitle: "e os estudos sobre a matemática",
                            imageName: "hipatiaAvatar",
                            descriptionText: "Hipátia foi uma matemática, astrônoma e filósofa grega. Ela foi a primeira mulher a estudar e ensinar matemática, além de ser uma das primeiras mulheres a estudar astronomia.  Neste jogo, você deve ajudar Hipátia a resolver uma equação matemática. Utilize o mouse para jogar.",
                            buttonAssetName: "playHipatia",
                            colorHex: "DED551"
                        ),
                        onContinue: { path.append(.game1) }
                    )
                case .instruction2:
                    InstructionView(
                        viewModel: InstructionViewModel(
                            title: "Ada Lovelace",
                            subtitle: "e a criação do algoritmo",
                            imageName: "adaAvatar",
                            descriptionText: "Ada Lovelace foi uma matemática e escritora inglesa.  Ela criou o primeiro algoritmo da história. Um algoritmo é uma sequência de ações que devem ser executadas para resolver um problema.  Ajude Ada a criar um algoritmo para resgatar seu cachorrinho passando pelo labirinto. Use as setas do teclado para criar uma sequência.",
                            buttonAssetName: "playAda",
                            colorHex: "E1AEE0"
                        ),
                        onContinue: { path.append(.game2) }
                    )
                case .instruction3:
                    InstructionView(
                        viewModel: InstructionViewModel(
                            title: "Hedy Lamarr",
                            subtitle: "e a ideia que surgiu de um dueto",
                            imageName: "hedyAvatar",
                            descriptionText: "Hedy Lamarr foi uma atriz e cientista austríaca. Ela utilizou a Música para criar o sistema de comunicação sem fio que deu origem ao Wi-fi e ao Bluetooth. A ideia para a invenção surgiu ao brincar de dueto com um amigo, onde um tocava o piano e o outro repetia as notas.  Neste jogo, você deve repetir a sequência de notas que Hedy apresentar, assim como ela fez com seu amigo. Clique nas teclas do piano para tocar as notas",
                            buttonAssetName: "playHedy",
                            colorHex: "8093CA"
                        ),
                        onContinue: { path.append(.game3) }
                    )
                case .instruction4:
                    InstructionView(
                        viewModel: InstructionViewModel(
                            title: "Joan Clarke",
                            subtitle: "e o trabalho com a criptografia",
                            imageName: "joanAvatar",
                            descriptionText: "Hedy Lamarr foi uma atriz e cientista austríaca. Ela utilizou a Música para criar o sistema de comunicação sem fio que deu origem ao Wi-fi e ao Bluetooth. A ideia para a invenção surgiu ao brincar de dueto com um amigo, onde um tocava o piano e o outro repetia as notas.  Neste jogo, você deve repetir a sequência de notas que Hedy apresentar, assim como ela fez com seu amigo. Clique nas teclas do piano para tocar as notas",
                            buttonAssetName: "playJoan",
                            colorHex: "C49461"
                        ),
                        onContinue: { path.append(.game4) }
                    )
                case .game1:
                    Screen1View()
                case .game2:
                    Screen2View()
                case .game3:
                    Screen3View()
                case .game4:
                    Screen4View()
                case .ranking:
                    RankingView()
                }
            }
        }
    }
}
