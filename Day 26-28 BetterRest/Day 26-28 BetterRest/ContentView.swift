//
//  ContentView.swift
//  Day 26-28 BetterRest
//
//  Created by Gienadij Mackiewicz on 24/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private properties
    
    @State private var sleepAmount = 8.0
    @State private var wakeUpTime = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Set number of hours you want to sleep:")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.5) {
                        Text("\(self.sleepAmount, specifier: "%.2g") hours")
                    }
                }
                Section {
                    DatePicker("Select wake up time", selection: $wakeUpTime, in: Date()..., displayedComponents: [.hourAndMinute])
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
