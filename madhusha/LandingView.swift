//
//  Landing.swift
//  madhusha
//
//  Created by COBSCCOMP242P-062 on 2026-01-17.
//

import SwiftUI

struct LandingView: View {

    @State private var startGame = false

    var body: some View {
        if startGame {
            ContentView()
        } else {
            VStack(spacing: 30) {

                Text("🎨 Cube Match")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Match 3 cubes of the same color\nbefore time runs out!")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)

                Button {
                    startGame = true
                } label: {
                    Text("▶️ Start Game")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 220)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
            .padding()
        }
    }
}
