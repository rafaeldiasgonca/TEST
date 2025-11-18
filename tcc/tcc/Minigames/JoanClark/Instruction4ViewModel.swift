import Foundation
import Combine

final class Instruction4ViewModel: ObservableObject {
    @Published var title: String = "Minigame 4"
    @Published var instructions: String = "Objetivo: Escreva um texto e envie.\nControles: Digite e toque em atualizar.\nDica: ..."
}
