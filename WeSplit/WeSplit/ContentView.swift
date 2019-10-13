//
//  ContentView.swift
//  WeSplit
//
//  Created by Gienadij Mackiewicz on 12/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

extension NSDecimalNumber {
    var localizedCurrencyString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pl-PL") // .current
        numberFormatter.numberStyle = .currency
        
        return numberFormatter.string(from: self) ?? ""
    }
}


struct ContentView: View {
    
    // MARK: - Private properties
    
    @State private var checkAmount: String = ""
    @State private var numberOfPeopleIndex: Int = 1
    @State private var tipPercentageIndex: Int = 0
    
    private let tipPercentages: [Int] = [0, 5, 10, 15, 20]
    
    private var checkAmountValue: NSDecimalNumber {
        guard let amountDoubleValue = Double(checkAmount),
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
        let peopleCount = NSDecimalNumber(integerLiteral: numberOfPeopleIndex + 2)
        let grandTotal = checkAmountValue.adding(tipValue)
        let roundingBehavior = NSDecimalNumberHandler(roundingMode: .up, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
        
        return grandTotal.dividing(by: peopleCount, withBehavior: roundingBehavior)
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeopleIndex) {
                        ForEach(2..<16) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentageIndex) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Price per person:")) {
                    Text("\(totalPricePerPerson.localizedCurrencyString)")
                }
                Section(header: Text("Tip total:")) {
                    Text("\(tipValue.localizedCurrencyString)")
                }
                Section(header: Text("Total price:")) {
                    Text("\(checkAmountValue.adding(tipValue).localizedCurrencyString)")
                }
            }
            .navigationBarTitle("We split")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
