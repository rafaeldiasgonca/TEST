// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen4ViewModel.swift
// ViewModel para o Minigame 4

import Foundation
import Combine

final class Screen4ViewModel: ObservableObject {
    @Published var text: String = "Pronto"

    func updateText(_ newText: String) {
        text = newText
    }
}
