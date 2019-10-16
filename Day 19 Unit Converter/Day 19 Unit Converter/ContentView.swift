//
//  ContentView.swift
//  Day 19 Unit Converter
//
//  Created by Gienadij Mackiewicz on 15/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private properties
    
    private enum SpeedUnit: CaseIterable {
        case metersPerSecond
        case kilometersPerHour
        case milesPerHour
        case knots
        
        var title: String {
            switch self {
            case .metersPerSecond:
                return "m/s"
            case .kilometersPerHour:
                return "km/h"
            case .milesPerHour:
                return "mph"
            case .knots:
                return "kn"
            }
        }
        
        var measurmentUnit: UnitSpeed {
            switch self {
            case .metersPerSecond:
                return .metersPerSecond
            case .kilometersPerHour:
                return .kilometersPerHour
            case .milesPerHour:
                return .milesPerHour
            case .knots:
                return .knots
            }
        }
    }
    
    @State private var inputUnitIndex: Int = 0
    @State private var outputUnitIndex: Int = 1
    @State private var textInput: String = ""
    
    private var units = SpeedUnit.allCases
    
    private var convertionResult: Double {
        guard let inputDoubleValue = Double(textInput.replacingOccurrences(of: ",", with: ".")),
            inputDoubleValue.isNaN == false else {
                return .zero
        }
        
        let measurment = Measurement(value: inputDoubleValue,
                                     unit: units[inputUnitIndex].measurmentUnit)
        
        return measurment.converted(to: units[outputUnitIndex].measurmentUnit).value
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select input unit")) {
                    Picker("Input unit", selection: $inputUnitIndex) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0].title)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Select output unit")) {
                    Picker(selection: $outputUnitIndex, label: Text("Output unit")) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0].title)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Enter speed value")) {
                    TextField("Speed value", text: $textInput).keyboardType(.decimalPad)
                }
                Section(header: Text("Result:")) {
                    Text("\(convertionResult, specifier: "%.2f")")
                }
            }
        .navigationBarTitle("Speed converter")
        }.colorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
