//import SwiftUI
//import Combine
//
//class UltimateComplexColorController: ObservableObject {
//    
//    @Published var tiles: [ComplexTile] = []
//    @Published var score: Int = 0
//    @Published var timeRemaining: Int
//    @Published var gameFinished: Bool = false
//    @Published var highScore: Int = UserDefaults.standard.integer(forKey: "ultimateHighScore")
//    @Published var matchedPairs: Int = 0
//    
//    private var timer: AnyCancellable?
//    private var firstSelectedIndex: Int? = nil
//    private var comboCount: Int = 0
//    
//    let gridSize: Int
//    let totalTime: Int
//    
//    init(size: Int) {
//        self.gridSize = size
//        self.totalTime = size * size // bigger grid → more time
//        self.timeRemaining = totalTime
//        startGame()
//    }
//    
//    func startGame() {
//        tiles = UltimateComplexColorController.generateGrid(size: gridSize)
//        score = 0
//        timeRemaining = totalTime
//        firstSelectedIndex = nil
//        gameFinished = false
//        comboCount = 0
//        matchedPairs = 0
//        startTimer()
//    }
//    
//    static func generateGrid(size: Int) -> [ComplexTile] {
//        let total = size * size
//        let pairCount = total / 2
//        var tiles: [ComplexTile] = []
//        
//        let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .yellow, .cyan, .mint, .indigo]
//        let patterns = ["stripe", "dot", "grid", "triangle"]
//        let shapes = ["circle", "square", "hexagon"]
//        
//        for i in 0..<pairCount {
//            let color = colors[i % colors.count]
//            let pattern = patterns[i % patterns.count]
//            let shape = shapes[i % shapes.count]
//            tiles.append(ComplexTile(color: color, pattern: pattern, shape: shape))
//            tiles.append(ComplexTile(color: color, pattern: pattern, shape: shape))
//        }
//        
//        if total % 2 != 0 {
//            tiles.append(ComplexTile(color: .gray, pattern: nil, shape: nil))
//        }
//        
//        tiles.shuffle()
//        return tiles
//    }
//    
//    func startTimer() {
//        timer?.cancel()
//        timer = Timer.publish(every: 1, on: .main, in: .common)
//            .autoconnect()
//            .sink { [weak self] _ in
//                guard let self = self else { return }
//                if self.timeRemaining > 0 {
//                    self.timeRemaining -= 1
//                } else {
//                    self.endGame()
//                }
//            }
//    }
//    
//    func stopTimer() { timer?.cancel() }
//    
//    func tileTapped(_ tile: ComplexTile) {
//        guard !gameFinished else { return }
//        guard let index = tiles.firstIndex(where: { $0.id == tile.id }) else { return }
//        guard !tiles[index].isFaceUp && !tiles[index].isMatched else { return }
//        
//        tiles[index].isFaceUp = true
//        
//        if firstSelectedIndex == nil {
//            firstSelectedIndex = index
//            return
//        }
//        
//        let firstIndex = firstSelectedIndex!
//        firstSelectedIndex = nil
//        
//        let firstTile = tiles[firstIndex]
//        let secondTile = tiles[index]
//        
//        // Matching logic: all three must match
//        if firstTile.color == secondTile.color &&
//            firstTile.pattern == secondTile.pattern &&
//            firstTile.shape == secondTile.shape {
//            
//            tiles[firstIndex].isMatched = true
//            tiles[index].isMatched = true
//            matchedPairs += 1
//            comboCount += 1
//            
//            // Combo bonus
//            let comboBonus = comboCount >= 3 ? 10 : 0
//            score += 10 + comboBonus
//            
//            // Optional: shuffle unmatched after some matches
//            if comboCount % 4 == 0 {
//                shuffleUnmatchedTiles()
//            }
//            
//            if tiles.allSatisfy({ $0.isMatched }) {
//                applyTimeBonus()
//                endGame()
//            }
//            
//        } else {
//            score -= 5 // Penalty
//            comboCount = 0
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
//                self.tiles[firstIndex].isFaceUp = false
//                self.tiles[index].isFaceUp = false
//            }
//        }
//    }
//    
//    private func shuffleUnmatchedTiles() {
//        var unmatched = tiles.filter { !$0.isMatched }
//        unmatched.shuffle()
//        var i = 0
//        for index in tiles.indices where !tiles[index].isMatched {
//            tiles[index] = unmatched[i]
//            i += 1
//        }
//    }
//    
//    private func applyTimeBonus() {
//        let percentLeft = Double(timeRemaining) / Double(totalTime)
//        if percentLeft >= 0.5 { score += 30 }
//        else if percentLeft >= 0.25 { score += 15 }
//    }
//    
//    private func endGame() {
//        stopTimer()
//        gameFinished = true
//        if score > highScore {
//            highScore = score
//            UserDefaults.standard.set(highScore, forKey: "ultimateHighScore")
//        }
//    }
//    
//    // Power-ups / Hint: show a random unmatched pair
//    func revealRandomPair(for duration: Double = 1.0) {
//        let unmatched = tiles.filter { !$0.isMatched && !$0.isFaceUp }
//        guard unmatched.count >= 2 else { return }
//        let pair = Array(unmatched.prefix(2))
//        for t in pair {
//            if let idx = tiles.firstIndex(where: { $0.id == t.id }) {
//                tiles[idx].isFaceUp = true
//            }
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//            for t in pair {
//                if let idx = self.tiles.firstIndex(where: { $0.id == t.id }) {
//                    self.tiles[idx].isFaceUp = false
//                }
//            }
//        }
//    }
//}
//
