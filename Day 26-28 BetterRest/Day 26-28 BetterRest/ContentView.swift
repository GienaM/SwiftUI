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
    @State private var coffeeAmount = 1
    @State private var bedTime: String = "-"

    @State private var isAlertShown = false
    
    private static var defaultWakeTime: Date {
         var components = DateComponents()
         components.hour = 6
         components.minute = 30
         return Calendar.current.date(from: components) ?? Date()
     }
    
    private var dateFormatter: DateFormatter {
       let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return dateFormatter
    }
    
    // MARK: - Body
    
    var body: some View {
        let wakeUpTimeBinding = Binding<Date> (
            get: {
                self.wakeUpTime
            },
            set: {
                self.wakeUpTime = $0
                self.calculateBedtime()
            }
        )
        
        let sleepAmountBinding = Binding<Double>(
            get: {
                self.sleepAmount
            },
            set: {
                self.sleepAmount = $0
                self.calculateBedtime()
            }
        )
        
        let coffeeAmountBinding = Binding<Int>(
            get: {
                self.coffeeAmount
            },
            set: {
                self.coffeeAmount = $0
                self.calculateBedtime()
            }
        )
        
        return NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Select wake up time", selection: wakeUpTimeBinding, displayedComponents: [.hourAndMinute])
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section(header: Text("Set number of hours you want to sleep")) {
                    Stepper(value: sleepAmountBinding, in: 4...12, step: 0.5) {
                        Text("\(self.sleepAmount, specifier: "%.2g") hours")
                    }
                }
                Section(header: Text("Set number of coffee cups")) {
                    Picker("Coffee cups", selection: coffeeAmountBinding) {
                        ForEach(0..<7) {
                            Text("\($0) \( $0 == 1 ? "cup" : "cups")")
                        }
                    }
                }
                Section(header: Text("Recommended bedtime").font(.headline).hCentered()) {
                        Text("\(bedTime)").font(.largeTitle).hCentered()
                    }
            }
            .navigationBarTitle("BetterRest")
                .alert(isPresented: $isAlertShown) {
                    Alert(title: Text("Error"), message: Text("Sorry, there was a problem calculating your bedtime."), dismissButton: .default(Text("OK")))
            }
        }.onAppear {
            self.calculateBedtime()
        }.colorScheme(.dark)
    }
    
    // MARK: - Private methods
    
    private func calculateBedtime() {
        let model = SleepCalculator()
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
        let hours = (dateComponents.hour ?? 0) * 60 * 60
        let minutes = (dateComponents.minute ?? 00) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUpTime - prediction.actualSleep
            self.bedTime = dateFormatter.string(from: sleepTime)
        } catch {
            self.bedTime = "-"
            isAlertShown = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
