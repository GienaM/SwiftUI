//
//  NSDecimalNumber+Extension.swift
//  Day 17-18 WeSplit
//
//  Created by Gienadij Mackiewicz on 20/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import Foundation

extension NSDecimalNumber {
    var localizedCurrencyString: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "pl-PL") // .current
        numberFormatter.numberStyle = .currency
        
        return numberFormatter.string(from: self) ?? ""
    }
}
