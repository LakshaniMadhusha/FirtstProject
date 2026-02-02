import SwiftUI

struct AdvancedComplexColorView: View {
    
    @StateObject private var controller: AdvancedComplexColorController
    @Environment(\.presentationMode) var presentationMode
    
    init(size: Int) {
        _controller = StateObject(wrappedValue: AdvancedComplexColorController(size: size))
    }
    
    var body: some View {
        VStack {
            if controller.gameFinished {
                ResultSummaryView(
                    score: controller.score,
                    timeRemaining: controller.timeRemaining,
                    gridSize: controller.gridSize,
                    highScore: controller.highScore,
                    onRestart: { controller.startGame() },
                    onHome: { presentationMode.wrappedValue.dismiss() }
                )
            } else {
                gameUI
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private var gameUI: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 6), count: controller.gridSize)
        
        return VStack(spacing: 8) {
            HStack {
                Text("⏱ \(controller.timeRemaining)s")
                    .foregroundColor(controller.timeRemaining <= 10 ? .red : .primary)
                    .font(.headline)
                Spacer()
                Text("Score: \(controller.score)")
                    .font(.headline)
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 6) {
                ForEach(controller.tiles) { tile in
                    ZStack {
                        Rectangle()
                            .fill(tile.isFaceUp || tile.isMatched ? tile.color : Color.gray.opacity(0.3))
                            .frame(height: 40)
                            .cornerRadius(6)
                        if tile.isFaceUp {
                            VStack {
                                if let pattern = tile.pattern {
                                    Text(pattern.prefix(1).uppercased())
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                                if let shape = tile.shape {
                                    Text(shape.prefix(1).uppercased())
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .bold()
                                }
                            }
                        }
                    }
                    .onTapGesture { controller.tileTapped(tile) }
                }
            }
            .padding()
            
            HStack(spacing: 15) {
                Button("Restart") { controller.startGame() }
                    .buttonStyle(.borderedProminent)
                Button("Home") { presentationMode.wrappedValue.dismiss() }
                    .buttonStyle(.bordered)
            }
            Spacer()
        }
    }
}
