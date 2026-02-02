import SwiftUI

struct LevelSelectionView: View {
    
    let gameType: GameType
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Select Level")
                .font(.title2)
                .bold()
            
            NavigationLink("Easy (3×3)") {
                startGame(size: 3)
            }
            
            NavigationLink("Medium (4×4)") {
                startGame(size: 4)
            }
            
            NavigationLink("Large (6×6)") {
                startGame(size: 6)
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func startGame(size: Int) -> some View {
        switch gameType {
        case .colorMatching:
            GameView(size: size) // Your existing Color Matching Game
        case .complexFirst:
            AdvancedComplexColorView(size: size) // NEW complex game
        }
    }
}
