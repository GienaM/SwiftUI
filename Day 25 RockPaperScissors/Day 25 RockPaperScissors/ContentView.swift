//
//  ContentView.swift
//  Day 25 RockPaperScissors
//
//  Created by Gienadij Mackiewicz on 21/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var appCurrentChoice: Int = Int.random(in: 0...2)
    @State private var playerShouldWin: Bool = Bool.random()
    @State private var currentScore: Int = 0
    @State private var questionCount: Int = 0
    @State private var isAlertPresented: Bool = true
    
    private let moves: [String] = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                ForEach(moves, id: \.self) { move in
                    Button(move) {
                        self.didPressMove(move)
                    }
                }
            }
            Text("Score: \(self.currentScore)")
        }.alert(isPresented: $isAlertPresented) {
            Alert(title: Text("\(moves[appCurrentChoice])"),
                  message: Text("You should \(playerShouldWin ? "WIN" : "LOSE")!"),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func didPressMove(_ move: String) {
        guard questionCount < 10 else {
            return
        }
        
        let moveIndex = moves.firstIndex(of: move)!
        let result: Bool
        
        if appCurrentChoice == moves.firstIndex(of: moves.last!)! {
            result = moveIndex == 0
        } else {
            result = moveIndex > appCurrentChoice
        }
        
        if playerShouldWin {
            currentScore += (result == true ? 1 : -1)
        } else {
            currentScore += (result == false ? 1 : -1)
        }
        
        appCurrentChoice = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
        questionCount += 1
        if questionCount < 10 {
            isAlertPresented = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
