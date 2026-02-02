import SwiftUI

struct Tile: Identifiable {
    let id = UUID()
    let color: Color
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}

class GameModel {

    static func generateGrid(size: Int) -> [Tile] {
        let total = size * size
        let pairCount = total / 2

        var colors: [Color] = []
        let baseColors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .yellow, .cyan]

        for i in 0..<pairCount {
            let color = baseColors[i % baseColors.count]
            colors.append(color)
            colors.append(color)
        }

        // If odd count (3×3), add one extra random tile
        if total % 2 != 0 {
            colors.append(.gray)
        }

        colors.shuffle()

        return colors.map { Tile(color: $0) }
    }
}

