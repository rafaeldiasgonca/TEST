import Foundation
import Combine

final class Instruction3ViewModel: ObservableObject {
    @Published var title: String = "Minigame 3"
    @Published var instructions: String = "Objetivo: Aumente o contador o máximo possível.\nControles: Toque no botão.\nDica: ..."
}
