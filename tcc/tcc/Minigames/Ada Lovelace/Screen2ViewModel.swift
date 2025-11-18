// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen2ViewModel.swift
// ViewModel para o Minigame 2

import Foundation
import Combine

final class Screen2ViewModel: ObservableObject {
    @Published var message: String = "Aguardando"

    func begin() {
        message = "Em jogo"
    }

    func reset() {
        message = "Aguardando"
    }
}
