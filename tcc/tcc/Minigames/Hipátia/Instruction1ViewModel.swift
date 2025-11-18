import Foundation
import Combine

final class Instruction1ViewModel: ObservableObject {
    @Published var title: String = "Minigame 1"
    @Published var instructions: String = "Objetivo: Faça X.\nControles: Toque para ...\nDica: Preste atenção em ..."
}
