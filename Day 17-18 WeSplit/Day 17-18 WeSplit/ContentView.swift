//
//  ContentView.swift
//  WeSplit
//
//  Created by Gienadij Mackiewicz on 12/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Private properties
    
    @State private var checkAmount: String = ""
    @State private var numberOfPeople: String = ""
    @State private var tipPercentageIndex: Int = 0
    
    private let tipPercentages: [Int] = [0, 5, 10, 15, 20]
    
    private var isTipZero: Bool {
        return tipPercentageIndex == 0 && checkAmountValue != .zero
    }
    
    private var checkAmountValue: NSDecimalNumber {
        guard let amountDoubleValue = Double(checkAmount.replacingOccurrences(of: ",", with: ".")),
            amountDoubleValue.isNaN == false else {
                return .zero
        }
        
        return NSDecimalNumber(value: amountDoubleValue)
    }
    
    private var tipValue: NSDecimalNumber {
        let tipPercentage = NSDecimalNumber(integerLiteral: tipPercentages[tipPercentageIndex])
                            .dividing(by: NSDecimalNumber(integerLiteral: 100))
        
        return checkAmountValue.multiplying(by: tipPercentage)
    }
    
    private var totalPricePerPerson: NSDecimalNumber {
        guard let numberOfPeopleInteger = Int(numberOfPeople) else {
            return .zero
        }
        let peopleCount = NSDecimalNumber(integerLiteral: numberOfPeopleInteger)
        let grandTotal = checkAmountValue.adding(tipValue)
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: .up, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        
        return grandTotal.dividing(by: peopleCount, withBehavior: roundingBehavior)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter the amount you want to split:")) {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Enter the number of pepople you want to split the check with:")) {
                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentageIndex) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Amount per person:")) {
                    Text("\(totalPricePerPerson.localizedCurrencyString)")
                }
                Section(header: Text("Tip total:")) {
                    Text("\(tipValue.localizedCurrencyString)")
                }
                Section(header: Text("Total amount*:"),
                        footer: Text("* including tip")) {
                    Text("\(checkAmountValue.adding(tipValue).localizedCurrencyString)")
                        .foregroundColor(isTipZero ? Color.red : Color.white)
                }
            }
            .navigationBarTitle("We split")
        }.colorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
