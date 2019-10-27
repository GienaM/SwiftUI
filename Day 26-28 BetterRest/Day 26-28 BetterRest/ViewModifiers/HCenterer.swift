//
//  HCenterer.swift
//  Day 26-28 BetterRest
//
//  Created by Gienadij Mackiewicz on 27/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct HCenterer: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
