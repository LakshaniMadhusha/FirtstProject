import SwiftUI

struct GameView: View {

    @StateObject private var controller: GameController

    init(size: Int) {
        _controller = StateObject(wrappedValue: GameController(size: size))
    }

    var body: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: controller.gridSize)

        VStack(spacing: 15) {

            HStack {
                Text("⏱ \(controller.timeRemaining)s")
                    .font(.headline)
                    .foregroundColor(controller.timeRemaining <= 10 ? .red : .primary)
                    .animation(.easeInOut, value: controller.timeRemaining)

                Spacer()

                Text("Score: \(controller.score)")
                    .font(.headline)
            }
            .padding(.horizontal)


            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(controller.tiles) { tile in
                    Rectangle()
                        .fill(tile.isFaceUp || tile.isMatched ? tile.color : Color.gray.opacity(0.3))
                        .frame(height: 55)
                        .cornerRadius(8)
                        .onTapGesture {
                            controller.tileTapped(tile)
                        }
                }
            }
            .padding()

            Button("Restart Game") {
                controller.startGame()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
