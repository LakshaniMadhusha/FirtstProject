//import SwiftUI
//
//struct AdaptiveLevelSelectionView: View {
//    
//    let gameType: GameType
//    
//    @State private var currentSize: Int = 3
//    @State private var autoProgress: Bool = false
//    
//    var body: some View {
//        VStack(spacing: 25) {
//            Text("Select Level")
//                .font(.title2)
//                .bold()
//            
//            // Manual selection for all types
//            levelButton(title: "Easy (3×3)", size: 3)
//            levelButton(title: "Medium (4×4)", size: 4)
//            levelButton(title: "Large (6×6)", size: 6)
//            
//            if gameType == .ultimateComplex {
//                levelButton(title: "Ultimate Challenge (8×8)", size: 8)
//            }
//            
//            // Automatic adaptive mode toggle
//            Toggle("Adaptive Progression", isOn: $autoProgress)
//                .padding(.top)
//            
//            Spacer()
//        }
//        .padding()
//    }
//    
//    @ViewBuilder
//    private func levelButton(title: String, size: Int) -> some View {
//        NavigationLink(title) {
//            startGame(size: size)
//        }
//    }
//    
//    @ViewBuilder
//    private func startGame(size: Int) -> some View {
//        switch gameType {
//        case .colorMatching:
//            ColorMatchingAdaptiveView(startSize: size, autoProgress: autoProgress)
//        case .complexFirst:
//            ComplexAdaptiveView(startSize: size, autoProgress: autoProgress)
//        case .ultimateComplex:
//            UltimateAdaptiveView(startSize: size, autoProgress: autoProgress)
//        }
//    }
//}
//
