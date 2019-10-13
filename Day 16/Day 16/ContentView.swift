//
//  ContentView.swift
//  Day 16
//
//  Created by Gienadij Mackiewicz on 12/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount: Int = 0
    @State private var name: String = ""
    private let students: [String] = ["Michael", "Peter", "John"]
    @State private var selectedStudent: String = "Michael"
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Hello world")
                }
                
                Section {
                    Text("End of an section")
                }
                Section {
                    Button("Tap count \(tapCount)") {
                        self.tapCount += 1
                    }
                }
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Your name is: \(self.name)")
                }
                Section {
                    ForEach(0..<2) {
                        Text("Row: \($0 + 1)")
                    }
                }
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(0..<students.count) {
                            Text(self.students[$0])
                        }
                    }
                }
            }
            .navigationBarTitle(Text("SwitUI"), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
