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
    
    @State private var showingAlert: Bool = false
    
    // MARK: - Body
    
    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            HStack(spacing: 10) {
                Image(systemName: "pencil").renderingMode(.original)
                Text("Show alert").foregroundColor(.primary)
            }
        }.alert(isPresented: $showingAlert) {
            Alert(title: Text("Hello SwiftUI"),
                  message: Text("This is some detail message"),
                  dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
