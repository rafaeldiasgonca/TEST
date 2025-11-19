import SwiftUI
import Combine
import UIKit

final class Screen1ViewModel: ObservableObject {
    @Published var x: Int = 0
    @Published private(set) var y: Int = 0
    @Published var z: Int = 0

    @Published var currentGuess: Int? = nil

    @Published var showErrorAlert: Bool = false

    init() {
        generateNewEquation()
    }

    func generateNewEquation() {
        x = Int.random(in: 0...9)
        y = Int.random(in: 0...9)
        z = x + y

        currentGuess = nil
        showErrorAlert = false
    }

    func tapDigit(_ digit: Int) {
        currentGuess = digit
    }

    func deleteLast() {
        currentGuess = nil
    }

    func confirm() {
        guard let guess = currentGuess else { return }

        if guess == y {
            generateNewEquation()
        } else {
            showErrorAlert = true

            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }

    var guessText: String {
        currentGuess.map { String($0) } ?? "?"
    }
}
