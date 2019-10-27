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
    @State private var wakeUpTime = defaultWakeTime
    @State private var coffeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isAlertShown = false
    
    private static var defaultWakeTime: Date {
         var components = DateComponents()
         components.hour = 7
         components.minute = 0
         return Calendar.current.date(from: components) ?? Date()
     }
    
    private var dateFormatter: DateFormatter {
       let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                VStack(alignment: .leading, spacing: .zero) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Select wake up time", selection: $wakeUpTime, displayedComponents: [.hourAndMinute])
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                VStack(alignment: .leading, spacing: .zero) {
                    Text("Set number of hours you want to sleep")
                        .font(.headline)
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.5) {
                        Text("\(self.sleepAmount, specifier: "%.2g") hours")
                    }
                }
                VStack(alignment: .leading, spacing: .zero) {
                    Text("Daily coffe intake")
                        .font(.headline)
                    Stepper(value: $coffeAmount, in: 0...20) {
                        coffeAmount == 1 ? Text("1 cup") : Text("\(coffeAmount) cups")
                    }
                }
            }
            .navigationBarTitle("BetterRest", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: calculateBedtime) {
                    Text("Calculate")
                }
            )
                .alert(isPresented: $isAlertShown) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func calculateBedtime() {
        let model = SleepCalculator()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
        let hours = (dateComponents.hour ?? 0) * 60 * 60
        let minutes = (dateComponents.minute ?? 00) * 60
        
        defer {
            isAlertShown = true
        }
        
        do {
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            let sleepTime = wakeUpTime - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = dateFormatter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
