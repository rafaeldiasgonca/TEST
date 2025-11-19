// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen1ViewModel.swift
// ViewModel para o Minigame 1

import Foundation
import Combine

final class Screen1ViewModel: ObservableObject {
    @Published var status: String = "Pronto"
    @Published var score: Int = 0

    func start() {
        status = "Iniciado"
        score = 0
    }

    func incrementScore() {
        score += 1
    }
}
