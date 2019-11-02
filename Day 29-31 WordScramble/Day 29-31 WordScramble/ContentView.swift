//
//  ContentView.swift
//  Day 29-31 WordScramble
//
//  Created by Gienadij Mackiewicz on 02/11/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let people = ["Finn", "Leia", "Luke", "Rey"]
    
    var body: some View {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt"){
            if let fileContents = try? String(contentsOf: fileURL) {
                
            }
        }
        
        let  word = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
        
        
        
        return List(people, id: \.self) {
            Text("\($0)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
