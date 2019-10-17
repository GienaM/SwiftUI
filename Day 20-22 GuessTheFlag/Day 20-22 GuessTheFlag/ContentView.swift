//
//  ContentView.swift
//  Day 20-22 GuessTheFlag
//
//  Created by Gienadij Mackiewicz on 16/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Privat properties
    
    @State private var countries: [String] = ["Estonia",
                                              "France",
                                              "Germany",
                                              "Irleand",
                                              "Italy",
                                              "Nigeria",
                                              "Poland",
                                              "Russia",
                                              "Spain",
                                              "UK",
                                              "US"].shuffled()
    @State var correctAnswer: Int = Int.random(in: 0...2)
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [.blue, .black]),
                           startPoint: .top,
                           endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack(spacing: 5) {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number]).renderingMode(.original)
                        .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("\(scoreTitle)"),
                  message: Text("Your score is not available yet"),
                  dismissButton: .default(Text("OK")){
                    self.askQuestion()
                })
        }
    }
    
    // MARK: - Private methods
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong, try again!"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
