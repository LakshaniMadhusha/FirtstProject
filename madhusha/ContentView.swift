import SwiftUI

struct ContentView: View {

    let size = 3
    let colors: [Color] = [.red, .green, .blue]
    
    let timeLimit = 60 // seconds
    
    @Environment(\.dismiss) private var dismiss


    // Grid starts blank
    @State private var grid: [[Color]] = Array(
        repeating: Array(repeating: .clear, count: 3),
        count: 3
    )

    // Track selected cubes
    @State private var selectedPositions: [(Int, Int)] = []

    // Match result
    @State private var isMatched = false

    // Score
    @State private var score = 0

    // High Score (saved)
    @State private var highScore = UserDefaults.standard.integer(forKey: "highScore")

    // Timer
    @State private var timeRemaining: Int = 60
    @State private var timerRunning = false
    @State private var timer: Timer? = nil

    // Game Over
    @State private var gameOver = false

    // Alert
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    

    
    var body: some View {
        VStack(spacing: 20) {

            Text("🎨 3 Cube Matching Game")
                .font(.largeTitle)
                .fontWeight(.bold)

            // Timer & Score
            HStack {
                Text("Score: \(score)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("High Score: \(highScore)")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("Time: \(timeRemaining)s")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)

            VStack(spacing: 10) {
                ForEach(0..<size, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<size, id: \.self) { col in
                            Rectangle()
                                .fill(grid[row][col] == .clear
                                      ? Color.gray.opacity(0.3)
                                      : grid[row][col])
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                )
                                .onTapGesture {
                                    if !gameOver {
                                        cubeTapped(row: row, col: col)
                                    }
                                }
                        }
                    }
                }
            }

            // Reset Button
            Button("Reset Game") {
                resetGame()
            }
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .onAppear {
            startTimer()
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                handleAfterAlert()
            }
        } message: {
            Text(alertMessage)
        }
    }

    // MARK: - Game Logic

    func cubeTapped(row: Int, col: Int) {
        if grid[row][col] != .clear { return }
        if selectedPositions.count == 3 { return }

        grid[row][col] = colors.randomElement()!
        selectedPositions.append((row, col))

        if selectedPositions.count == 3 {
            checkMatch()
        }
    }

    func checkMatch() {
        let selectedColors = selectedPositions.map { grid[$0.0][$0.1] }
        let firstColor = selectedColors.first!
        isMatched = selectedColors.allSatisfy { $0 == firstColor }

        if isMatched {
            score += 1
            if score > highScore {
                highScore = score
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
            alertTitle = "🎉 Matched!"
            alertMessage = "Score +1"
        } else {
            alertTitle = "❌ Not Matched"
            alertMessage = "Cubes will be cleared"
        }

        showAlert = true
    }

    func handleAfterAlert() {
        if !isMatched {
            for (row, col) in selectedPositions {
                grid[row][col] = .clear
            }
        }
        selectedPositions.removeAll()
        isMatched = false
    }

    func resetGame() {
        grid = Array(repeating: Array(repeating: .clear, count: size), count: size)
        selectedPositions.removeAll()
        score = 0
        timeRemaining = timeLimit
        gameOver = false
        startTimer()
    }

    // MARK: - Timer
    func startTimer() {
        timer?.invalidate()
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer?.invalidate()
                timerRunning = false
                gameOver = true
                alertTitle = "⏰ Time's Up!"
                alertMessage = "Your final score is \(score)"
                showAlert = true
            }
        }
    }
}


//ftrtrrttyg
//import SwiftUI
//
//struct LandingView: View {
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 25) {
//
//                Spacer()
//
//                // Game Emoji / Icon
//                Text("🎨")
//                    .font(.system(size: 90))
//
//                // Game Title
//                Text("3 Cube Matching Game")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
//
//                // Description
//                Text("Tap any 3 cubes and match the same color before the timer ends.")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//                    .multilineTextAlignment(.center)
//                    .padding(.horizontal)
//
//                Spacer()
//
//                // Start Game Button
//                NavigationLink(destination: ContentView()) {
//                    Text("Start Game")
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.black)
//                        .foregroundColor(.white)
//                        .cornerRadius(14)
//                        .padding(.horizontal, 40)
//                }
//
//                Spacer()
//
//                // Info Row
//                HStack(spacing: 20) {
//                    Label("60s", systemImage: "timer")
//                    Label("Match 3", systemImage: "square.grid.3x3")
//                    Label("Score", systemImage: "star.fill")
//                }
//                .foregroundColor(.gray)
//                .font(.footnote)
//
//                Spacer()
//            }
//            .padding()
//        }
//    }
//}
