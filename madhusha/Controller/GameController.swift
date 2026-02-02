import SwiftUI
import Combine

class GameController: ObservableObject {

    // MARK: - Published
    @Published var tiles: [Tile] = []
    @Published var score: Int = 0
    @Published var timeRemaining: Int = 60
    @Published var gameFinished: Bool = false


    // MARK: - Private
    private var timer: AnyCancellable?
    private var firstSelectedIndex: Int? = nil
    let gridSize: Int
    let totalTime: Int

    init(size: Int) {
        self.gridSize = size

        // Adjust time based on difficulty
        switch size {
        case 3: totalTime = 40
        case 4: totalTime = 60
        default: totalTime = 90
        }

        startGame()
    }

    // MARK: - Game Start
    func startGame() {
        tiles = GameModel.generateGrid(size: gridSize)
        score = 0
        timeRemaining = totalTime
        firstSelectedIndex = nil
        gameFinished = false
        startTimer()
    }


    // MARK: - Timer
    func startTimer() {
        timer?.cancel()
        timer = Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.cancel()
                    self.gameFinished = true
                }

            }
    }

    func stopTimer() {
        timer?.cancel()
    }

    // MARK: - Tile Tap Logic
    func tileTapped(_ tile: Tile) {
        guard timeRemaining > 0 else { return }
        guard let index = tiles.firstIndex(where: { $0.id == tile.id }) else { return }
        guard !tiles[index].isFaceUp && !tiles[index].isMatched else { return }

        tiles[index].isFaceUp = true

        if firstSelectedIndex == nil {
            firstSelectedIndex = index
            return
        }

        let firstIndex = firstSelectedIndex!
        firstSelectedIndex = nil

        if tiles[firstIndex].color == tiles[index].color {
            // ✅ MATCH
            tiles[firstIndex].isMatched = true
            tiles[index].isMatched = true
            score += 10

            // 🎉 All matched → bonus
            if tiles.filter({ !$0.isMatched }).isEmpty {
                applyTimeBonus()
                stopTimer()
                gameFinished = true
            }

        } else {
            // ❌ WRONG
            score -= 5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.tiles[firstIndex].isFaceUp = false
                self.tiles[index].isFaceUp = false
            }
        }
    }

    // MARK: - Time Bonus
    func applyTimeBonus() {
        let percentageLeft = Double(timeRemaining) / Double(totalTime)

        if percentageLeft >= 0.5 {
            score += 30
        } else if percentageLeft >= 0.25 {
            score += 15
        }
    }
}
