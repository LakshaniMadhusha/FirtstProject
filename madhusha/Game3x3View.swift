//import SwiftUI
//
//struct Game3x3View: View {
//    @State private var goTo4x4 = false
//    var manager: GameManager
//    
//    var body: some View {
//        CubeGameView(
//            size: 3,
//            matchCount: 3,
//            timeLimit: 60,
//            manager: manager
//        ) {
//            goTo4x4 = true
//        }
//        .navigationDestination(isPresented: $goTo4x4) {
//            Game4x4View(manager: manager)
//        }
//    }
//}
