import SwiftUI

struct LandingView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                Text("🎮 Game Hub")
                    .font(.largeTitle)
                    .bold()
                
                // Simple Color Matching Game
                NavigationLink("Color Matching Game") {
                    LevelSelectionView(gameType: .colorMatching)
                }
                .buttonStyle(.borderedProminent)
                
                // Complex First Game (advanced)
                NavigationLink("Complex First Game") {
                    LevelSelectionView(gameType: .complexFirst)
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}

enum GameType {
    case colorMatching
    case complexFirst
    
}
