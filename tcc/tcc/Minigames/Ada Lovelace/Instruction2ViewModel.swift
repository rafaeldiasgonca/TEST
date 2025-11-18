import Foundation
import Combine

final class Instruction2ViewModel: ObservableObject {
    @Published var title: String = "Minigame 2"
    @Published var instructions: String = "Objetivo: Colete 10 itens.\nControles: Swipe/Toque.\nDica: ..."
}
