//
//  ContentView.swift
//  Day 29-31 WordScramble
//
//  Created by Gienadij Mackiewicz on 02/11/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private properties
    
    private let words: [String]
    @State private var usedWords: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    @State private var totalScore: Int = 0
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var showingError: Bool = false
    
    // MARK: - Initialization
    
    init() {
        guard let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let words = try? String(contentsOf: fileURL)
                .components(separatedBy: .newlines) else {
                    fatalError("Couldn't locate start.txt file in the app main bundle")
        }
        
        self.words = words
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }.gesture(DragGesture().onChanged({ _ in
                    UIApplication.shared.windows.forEach { $0.endEditing(true) }
                }))
                Text("Total score: \(self.totalScore)")
                    .fontWeight(.semibold)
                    .modifier(KeyboardObserving())
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading: Button(action: resetScore, label: {
                Text("Reset score")
            }),trailing: Button(action: nextWord, label: {
                Text("Next word")
            }))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(title: Text(errorTitle),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func startGame() {
        rootWord = words.randomElement() ?? "silkworm"
    }
    
    private func resetScore() {
        nextWord()
        totalScore = 0
    }
    
    private func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original.")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        usedWords.insert(answer, at: 0)
        newWord = ""
        calculateScore()
    }
    
    private func nextWord() {
        usedWords.removeAll()
        startGame()
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    private func isOriginal(word: String) -> Bool {
        usedWords.contains(word) == false && rootWord != word
    }
    
    private func isPossible(word: String) -> Bool {
        var rootWord = self.rootWord
        
        for letter in word {
            if let index = rootWord.firstIndex(of: letter) {
                rootWord.remove(at: index)
            } else {
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker
            .rangeOfMisspelledWord(in: word,
                                   range: range,
                                   startingAt: 0,
                                   wrap: false,
                                   language: "en")
        
        return misspelledRange.location == NSNotFound && word.count > 2
    }
    
    private func calculateScore() {
        totalScore += (usedWords.reduce(0) { $0 + $1.count } * usedWords.count)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
