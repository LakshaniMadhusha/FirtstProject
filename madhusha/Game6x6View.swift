//import SwiftUI
//
//struct Game6x6View: View {
//    @State private var showFinal = false
//    var manager: GameManager
//    
//    var body: some View {
//        CubeGameView(
//            size: 6,
//            matchCount: 2,
//            timeLimit: 45,
//            manager: manager
//        ) {
//            showFinal = true
//        }
//        .navigationDestination(isPresented: $showFinal) {
//            FinalScoreView(manager: manager)
//        }
//    }
//}
