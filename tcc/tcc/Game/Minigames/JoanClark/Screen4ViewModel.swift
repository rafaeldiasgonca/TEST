// filepath: /Users/rafaeldiasgoncalves/TEST/tcc/tcc/Minigames/Screen4View.swift
// View para o Minigame 4 (MVVM)



import Foundation
import Combine
import SwiftUI

final class Screen4ViewModel: ObservableObject {
    @Published private(set) var secretWord: String = ""
    @Published private(set) var cipherMapping: [Character: Character] = [:]
    @Published private(set) var displayedKeyPairs: [(Character, Character)] = [] // máximo 4 pares
    @Published var userSlots: [Character?] = []
    @Published private(set) var isGameOver: Bool = false
    @Published private(set) var isWin: Bool = false
    @Published private(set) var cipherWord: String = "" // palavra cifrada para exibição
    @Published private(set) var shiftValue: Int = 0 // deslocamento do ciframento de César

    let alphabet: [Character] = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

    private let portugueseWords: [String] = [
        "LIVRO","CIENCIA","LOGICA","CRIPTO","AZUL","FLOR","PENSAR","MUNDO","CODIGO","SEGREDO","PRISMA","FORMULA","LISTA","JOGO","NOTA","TECLA","VALOR","RITMO","CHEFE","PORTA"
    ].filter { $0.count <= 10 }

    func startNewGame() {
        isGameOver = false; isWin = false
        secretWord = portugueseWords.randomElement() ?? "LOGICA"
        generateCipherMapping()
        userSlots = Array(repeating: nil, count: secretWord.count)
        cipherWord = encode(secretWord) // gera a palavra cifrada
        buildDisplayedKeyPairs()
    }

    func selectLetter(_ letter: Character) {
        guard !isGameOver else { return }
        if let idx = userSlots.firstIndex(where: { $0 == nil }) {
            userSlots[idx] = letter
            if userSlots.allSatisfy({ $0 != nil }) { evaluate() }
        }
    }

    func removeLast() {
        guard let idx = userSlots.lastIndex(where: { $0 != nil }) else { return }
        userSlots[idx] = nil
        isGameOver = false; isWin = false
    }

    private func evaluate() {
        let guess = String(userSlots.compactMap { $0 })
        isGameOver = true
        isWin = (guess == secretWord)
    }

    private func generateCipherMapping() {
        // Cifra de César: escolhe deslocamento aleatório entre 1 e 25
        shiftValue = Int.random(in: 1...25)
        var mapping: [Character: Character] = [:]
        for (index, plain) in alphabet.enumerated() {
            let cipherIndex = (index + shiftValue) % alphabet.count
            let cipherChar = alphabet[cipherIndex]
            mapping[plain] = cipherChar
        }
        cipherMapping = mapping
    }

    // Função para codificar palavra segundo mapeamento (plaintext -> cipher)
    private func encode(_ word: String) -> String {
        String(word.map { cipherMapping[$0] ?? $0 })
    }

    // Função auxiliar para decodificar (cipher -> plaintext) caso queira validar internamente
    private func decode(_ word: String) -> String {
        // Inverso do mapeamento de César: aplica deslocamento negativo
        String(word.map { ch in
            guard let idx = alphabet.firstIndex(of: ch) else { return ch }
            let plainIndex = (idx - shiftValue + alphabet.count) % alphabet.count
            return alphabet[plainIndex]
        })
    }

    private func buildDisplayedKeyPairs() {
        // Dicas fixas: sempre mostrar pares para A, B, C e D
        let fixedKeys: [Character] = ["A","B","C","D"]
        displayedKeyPairs = fixedKeys.compactMap { key in
            guard let mapped = cipherMapping[key] else { return nil }
            return (key, mapped)
        }
    }
}
