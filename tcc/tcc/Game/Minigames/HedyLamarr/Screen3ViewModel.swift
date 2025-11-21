import Foundation
import Combine
import AVFoundation

final class Screen3ViewModel: ObservableObject {
    @Published var counter: Int = 0

    private var audioPlayers: [Int: AVAudioPlayer] = [:]
    private let soundFileNames: [Int: String] = [
        0: "noteC",
        1: "noteD",
        2: "noteE",
        3: "noteF",
        4: "noteG",
        5: "noteA",
        6: "noteB"
    ]

    private let possibleExtensions = ["mp3", "wav", "aiff"]
    private var audioSessionConfigured = false

    func prepareAudio(preload: Bool = true) {
        configureAudioSession()
        if preload {
            for (index, _) in soundFileNames { _ = loadPlayer(for: index) }
        }
    }

    private func configureAudioSession() {
        guard !audioSessionConfigured else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
            audioSessionConfigured = true
        } catch {
            print("[Audio] Falha ao configurar sessão: \(error)")
        }
    }

    private func loadPlayer(for index: Int) -> AVAudioPlayer? {
        if let existing = audioPlayers[index] { return existing }
        guard let baseName = soundFileNames[index] else { return nil }
        for ext in possibleExtensions {
            if let url = Bundle.main.url(forResource: baseName, withExtension: ext) {
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    audioPlayers[index] = player
                    print("[Audio] Carregado: \(baseName).\(ext)")
                    return player
                } catch {
                    print("[Audio] Erro carregando \(baseName).\(ext): \(error)")
                }
            }
        }
        print("[Audio] Arquivo não encontrado para \(baseName) (tentado: \(possibleExtensions.joined(separator: ", ")))" )
        return nil
    }

    func playKey(at index: Int) {
        let player = loadPlayer(for: index)
        player?.currentTime = 0
        player?.play()
    }

    func stopKey(at index: Int) {
        if let player = audioPlayers[index], player.isPlaying {
            player.stop()
            player.currentTime = 0
        }
    }
}
