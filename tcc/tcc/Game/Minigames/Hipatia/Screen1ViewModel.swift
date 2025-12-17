import SwiftUI
import Combine
import UIKit

final class Screen1ViewModel: ObservableObject {
    @Published var x: Int = 0
    @Published private(set) var y: Int = 0
    @Published var z: Int = 0

    @Published var currentGuess: Int? = nil

    // Scoring
    @Published private(set) var score: Int = 0
    @Published private(set) var highScore: Int = 0
    private let highScoreKey = "score_hipatia"

    // Alerts
    @Published var showErrorAlert: Bool = false
    @Published var alertMessage: String = ""

    init() {
        highScore = UserDefaults.standard.integer(forKey: highScoreKey)
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
            // Correct: add 5 points
            score += 5
            // Update high score if beaten immediately
            if score > highScore {
                highScore = score
                UserDefaults.standard.set(highScore, forKey: highScoreKey)
            }
            generateNewEquation()
        } else {
            // Wrong: show alert with points and record info
            let beatRecord = score > highScore
            if beatRecord {
                highScore = score
                UserDefaults.standard.set(highScore, forKey: highScoreKey)
            }
            alertMessage = beatRecord
                ? "Você fez \(score) pontos e bateu seu recorde!"
                : "Você fez \(score) pontos."
            showErrorAlert = true

            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)

            // Reset current input only
            currentGuess = nil
        }
    }

    var guessText: String {
        currentGuess.map { String($0) } ?? "?"
    }
}
