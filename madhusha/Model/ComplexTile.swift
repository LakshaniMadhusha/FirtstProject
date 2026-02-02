import SwiftUI

struct ComplexTile: Identifiable {
    let id = UUID()
    let color: Color
    let pattern: String?      // "stripe", "dot", "grid", "triangle"
    let shape: String?        // "circle", "square", "hexagon"
    
    var isFaceUp: Bool = false
    var isMatched: Bool = false
}
