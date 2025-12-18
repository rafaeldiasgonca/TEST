//
//  InstructionView.swift
//  tcc
//

import SwiftUI
import Combine

// Generic ViewModel for instruction screens
final class InstructionViewModel: ObservableObject {
    @Published var title: String
    @Published var subtitle: String
    @Published var imageName: String
    @Published var descriptionText: String
    @Published var buttonAssetName: String
    @Published var colorHex: String


    init(title: String,
         subtitle: String = "",
         imageName: String = "",
         descriptionText: String = "",
         buttonAssetName: String = "",
         colorHex: String = "") {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.descriptionText = descriptionText
        self.buttonAssetName = buttonAssetName
        self.colorHex = colorHex
    }
}

struct InstructionView: View {
    @StateObject private var viewModel: InstructionViewModel
    @Environment(\.dismiss) private var dismiss
    var onContinue: (() -> Void)?

    init(viewModel: InstructionViewModel, onContinue: (() -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onContinue = onContinue
    }

    var body: some View {
        ZStack {
            // 1) Pinta a tela inteira
            Color.white.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    // Grupo título + subtítulo
                    VStack(spacing: 6) {
                        Text(viewModel.title)
                            .fontWeight(.semibold)
                            .font(.custom("LazySunday", size: 64))
                            .foregroundColor(Color(hex: viewModel.colorHex))

                        if !viewModel.subtitle.isEmpty {
                            Text(viewModel.subtitle)
                                .foregroundColor(Color(hex: viewModel.colorHex))
                                .font(.custom("LazySunday", size: 32))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top)

                    if !viewModel.imageName.isEmpty {
                        Image(viewModel.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 380, maxHeight: 380)
                            .clipped()
                    }

                    if !viewModel.descriptionText.isEmpty {
                        Text(viewModel.descriptionText)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                            .font(.custom("LazySunday", size: 20))
                            .frame(maxWidth: 500, alignment: .leading) // limita largura do texto
                    }

                    Button(action: {
                        Haptics.trigger(.selection)
                        onContinue?()
                    }) {
                        if !viewModel.buttonAssetName.isEmpty {
                            Image(viewModel.buttonAssetName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 88)
                        } else {
                            Text("Começar")
                                .font(.custom("LazySunday", size: 20))
                        }
                    }
                }
                // Centraliza a coluna de conteúdo na tela larga
                .frame(maxWidth: .infinity)
                .padding()
            }
            // 2) ScrollView ocupando a tela toda
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity,
                   alignment: .top)
            .scrollIndicators(.hidden)
        }
    }
}


struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionView(
            viewModel: InstructionViewModel(
                title: "Hipátia",
                subtitle: "e os estudos sobre a matemática",
                imageName: "hipatiaAvatar",
                descriptionText: "Hipátia foi uma matemática, astrônoma e filósofa grega. Ela foi a primeira mulher a estudar e ensinar matemática, além de ser uma das primeiras mulheres a estudar astronomia.  Neste jogo, você deve ajudar Hipátia a resolver uma equação matemática. Utilize o mouse para jogar.",
                buttonAssetName: "playHipatia",
                colorHex: "DED551"
            ),
            onContinue: {}
        )
    }
}
