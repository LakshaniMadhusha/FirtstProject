import SwiftUI

struct ResultSummaryView: View {

    let score: Int
    let timeRemaining: Int
    let gridSize: Int
    let highScore: Int
    let onRestart: () -> Void
    let onHome: () -> Void

    var body: some View {
        VStack(spacing: 20) {

            Text("🎉 Game Over")
                .font(.largeTitle)
                .bold()

            Text("Grid Size: \(gridSize) × \(gridSize)")
                .font(.headline)

            Text("Final Score")
                .font(.title2)

            Text("\(score)")
                .font(.system(size: 48, weight: .bold))
                .foregroundColor(.blue)

            Text("⏱ Time Left: \(timeRemaining)s")
                .font(.headline)
            
            Text("🏅 High Score: \(highScore)")
                .font(.headline)
                .foregroundColor(.orange)

            Spacer()

            Button("🔄 Play Again") {
                onRestart()
            }
            .buttonStyle(.borderedProminent)

            Button("🏠 Back to Home") {
                onHome()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
