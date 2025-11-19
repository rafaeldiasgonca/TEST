// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen3ViewModel.swift
// ViewModel para o Minigame 3

import Foundation
import Combine

final class Screen3ViewModel: ObservableObject {
    @Published var counter: Int = 0

    func increase() {
        counter += 1
    }

    func reset() {
        counter = 0
    }
}
