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
                                              "Ireland",
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
    @State private var score: Int = 0
    @State private var selectedCountry: String = ""
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: .init(colors: [.blue, .black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                VStack {
                    Text("Tap the flag of:")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }.lineLimit(nil)
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                }
                Spacer()
                ZStack {
                    Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.3016909247))
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .medium))
                }.frame(maxHeight: 50)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("\(scoreTitle)"),
                  message: Text("Your current score: \(score)"),
                  dismissButton: .default(Text("OK")){
                    self.askQuestion()
                })
        }
    }
    
    // MARK: - Private methods
    
    func flagTapped(_ number: Int) {
        selectedCountry = countries[number]
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct!"
        } else {
            if score > 0 {
                score -= 1
            }
            scoreTitle = "Wrong! That's the flag of \(selectedCountry)"
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
