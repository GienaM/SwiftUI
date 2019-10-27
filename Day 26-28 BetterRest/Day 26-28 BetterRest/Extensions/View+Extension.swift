//
//  View+Extension.swift
//  Day 26-28 BetterRest
//
//  Created by Gienadij Mackiewicz on 27/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

extension View {
    func hCentered() -> some View {
        self.modifier(HCenterer())
    }
}
