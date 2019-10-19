//
//  ContentView.swift
//  Day 23-24 ViewsAndModifiers
//
//  Created by Gienadij Mackiewicz on 19/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private properties
    
    @State private var useRedText: Bool = false
    @State private var textFieldText: String = ""
    
    private let motto1Text = Text("Draco dormiens")
    private let motto2Text = Text("nunquam titillandus")
    
    private var textField: some View {
        TextField("XD", text: $textFieldText)
    }
    
    var body: some View {
        Form {
            Section {
                Text("Hello World")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .edgesIgnoringSafeArea(.all)
            }
            Section {
                Button("Hello world") {
                    print(type(of: self.body))
                }
                .frame(width: 200, height: 200)
                .background(Color.red)
            }
            Section {
                Text("Hello world")
                .padding()
                    .background(Color.gray)
                .padding()
                    .background(Color.red)
                .padding()
                    .background(Color.green)
                .padding()
                    .background(Color.orange)
            }
            Section {
                Button("Hello world") {
                    // to flip a boolean
                    self.useRedText.toggle()
                }
                .foregroundColor(useRedText ? .red : .blue)
            }
            Section {
                HStack{
                    Text("Gryffindor")
                        .font(.largeTitle)
                        .blur(radius: 0)
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                    Text("Slytherin")
                }
                .font(.headline)
                .blur(radius: 3)
            }
            Section {
                motto1Text
                    .foregroundColor(.red)
                motto2Text
                    .foregroundColor(.blue)
                textField
            }
            Section {
                CapsuleText(text: "First")
                    .foregroundColor(.red)
                CapsuleText(text: "Second")
                    .foregroundColor(.yellow)
            }
            Section {
                Text("Hello world")
                .titleStyle()
            }
            Section {
                Color
                    .blue
                    .frame(width: 300, height: 300)
                    .watermaked(with: "Hacking with SwiftUI")
            }
            Section {
                GridStack(rows: 5, columns: 3) { row, column in
                    ZStack {
                        Color
                            .red
                            .frame(idealWidth: .infinity, idealHeight: 100)
                        VStack {
                            Image(systemName: "\(row * 4 + column).circle")
                            Text("R\(row) C\(column)")
                        }
                        .foregroundColor(.white)
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
