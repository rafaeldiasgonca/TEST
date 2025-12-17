import SwiftUI

struct RankingView: View {
    private let entries: [(name: String, colorHex: String, key: String)] = [
        ("Hipátia", "#DED551", "score_hipatia"),
        ("Ada Lovelace", "#E1AEE0", "score_ada"),
        ("Hedy Lamarr", "#8093CA", "score_hedy"),
        ("Joan Clarke", "#C49461", "score_joan")
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.ignoresSafeArea()

                VStack(spacing: 16) {
                    Text("Ranking")
                        .font(.custom("LazySunday", size: 48))
                        .foregroundColor(Color(hex: "#1893BA"))
                        .padding(.top, 24)

                    ForEach(entries, id: \.name) { entry in
                        let score = UserDefaults.standard.integer(forKey: entry.key)
                        rankingRow(title: entry.name, score: score, color: entry.colorHex)
                    }

                    Spacer()
                }
                .frame(maxWidth: min(geometry.size.width * 0.6, 420))
                .padding()
            }
        }
        .navigationTitle("Ranking")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
    }

    private func rankingRow(title: String, score: Int, color: String) -> some View {
        VStack(spacing: 6) {
            Text(title)
                .font(.custom("LazySunday", size: 28))
                .foregroundColor(Color(hex: color))
            Text("\(score)")
                .font(.custom("LazySunday", size: 26))
                .foregroundColor(Color(hex: color))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

#Preview("Ranking") {
    RankingView()
}
