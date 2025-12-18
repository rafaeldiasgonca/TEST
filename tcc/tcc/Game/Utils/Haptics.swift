import Foundation
#if canImport(UIKit)
import UIKit
#endif

enum HapticType {
    case impactLight
    case impactMedium
    case impactHeavy
    case selection
    case success
    case warning
    case error
}

enum Haptics {
    #if canImport(UIKit)
    // Cached generators to avoid allocation on every tap
    private static let lightGen = UIImpactFeedbackGenerator(style: .light)
    private static let mediumGen = UIImpactFeedbackGenerator(style: .medium)
    private static let heavyGen = UIImpactFeedbackGenerator(style: .heavy)
    private static let selectionGen = UISelectionFeedbackGenerator()
    private static let noteGen = UINotificationFeedbackGenerator()
    #endif

    static func trigger(_ type: HapticType) {
        #if canImport(UIKit)
        switch type {
        case .impactLight:
            lightGen.prepare(); lightGen.impactOccurred()
        case .impactMedium:
            mediumGen.prepare(); mediumGen.impactOccurred()
        case .impactHeavy:
            heavyGen.prepare(); heavyGen.impactOccurred()
        case .selection:
            selectionGen.prepare(); selectionGen.selectionChanged()
        case .success:
            noteGen.prepare(); noteGen.notificationOccurred(.success)
        case .warning:
            noteGen.prepare(); noteGen.notificationOccurred(.warning)
        case .error:
            noteGen.prepare(); noteGen.notificationOccurred(.error)
        }
        #else
        _ = type
        #endif
    }
}
