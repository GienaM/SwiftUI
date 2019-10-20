//
//  BlueFont.swift
//  Day 23-24 ViewsAndModifiers
//
//  Created by Gienadij Mackiewicz on 20/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct BlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}
