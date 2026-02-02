//import SwiftUI
//
//struct Game4x4View: View {
//    @State private var goTo6x6 = false
//    var manager: GameManager
//    
//    var body: some View {
//        CubeGameView(
//            size: 4,
//            matchCount: 2,
//            timeLimit: 50,
//            manager: manager
//        ) {
//            goTo6x6 = true
//        }
//        .navigationDestination(isPresented: $goTo6x6) {
//            Game6x6View(manager: manager)
//        }
//    }
//}
