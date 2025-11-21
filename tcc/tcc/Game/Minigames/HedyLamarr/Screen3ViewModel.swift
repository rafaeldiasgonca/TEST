import Foundation
import Combine
import AVFoundation

final class Screen3ViewModel: ObservableObject {
    @Published var counter: Int = 0
    @Published private(set) var sequence: [Int] = []
    @Published private(set) var currentInputIndex: Int = 0
    @Published private(set) var score: Int = 0
    @Published private(set) var phase: Phase = .idle

    enum Phase { case idle, showingSequence, waitingInput, roundCompleted, gameOver }

    private var audioPlayers: [Int: AVAudioPlayer] = [:]
    private let soundFileNames: [Int: String] = [
        0: "noteC", 1: "noteD", 2: "noteE", 3: "noteF", 4: "noteG", 5: "noteA", 6: "noteB"
    ]
    private let possibleExtensions = ["mp3", "wav", "aiff"]
    private var audioSessionConfigured = false

    private let endOfRoundDelay: Double = 1.0 // atraso após usuário completar sequência

    func prepareAudio(preload: Bool = true) {
        configureAudioSession(); if preload { for (index, _) in soundFileNames { _ = loadPlayer(for: index) } }
    }

    func startGame() {
        score = 0; sequence = [randomKeyIndex()]; currentInputIndex = 0; phase = .showingSequence
    }

    func nextRound() {
        sequence.append(randomKeyIndex()); currentInputIndex = 0; phase = .showingSequence
    }

    private func randomKeyIndex() -> Int { Int.random(in: 0..<soundFileNames.count) }

    func handleUserPress(_ index: Int) {
        guard phase == .waitingInput else { return }
        if sequence[currentInputIndex] == index {
            score += 10
            currentInputIndex += 1
            if currentInputIndex == sequence.count {
                // rodada completa -> aplica delay antes da próxima sequência
                phase = .roundCompleted
                DispatchQueue.main.asyncAfter(deadline: .now() + endOfRoundDelay) { [weak self] in
                    self?.nextRound()
                }
            }
        } else {
            phase = .gameOver
        }
    }

    func sequencePresentationFinished() {
        if phase == .showingSequence { phase = .waitingInput; currentInputIndex = 0 }
    }

    // Áudio
    private func configureAudioSession() {
        guard !audioSessionConfigured else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            audioSessionConfigured = true
        } catch { print("[Audio] Falha ao configurar sessão: \(error)") }
    }

    private func loadPlayer(for index: Int) -> AVAudioPlayer? {
        if let existing = audioPlayers[index] { return existing }
        guard let baseName = soundFileNames[index] else { return nil }
        for ext in possibleExtensions {
            if let url = Bundle.main.url(forResource: baseName, withExtension: ext) {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay(); audioPlayers[index] = player; return player
                } catch { print("[Audio] Erro carregando \(baseName).\(ext): \(error)") }
            }
        }
        print("[Audio] Arquivo não encontrado para \(baseName) (tentado: \(possibleExtensions.joined(separator: ", ")))" ); return nil
    }

    func playKey(at index: Int) { let player = loadPlayer(for: index); player?.currentTime = 0; player?.play() }
    func stopKey(at index: Int) { if let p = audioPlayers[index], p.isPlaying { p.stop(); p.currentTime = 0 } }
}
