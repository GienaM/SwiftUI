//
//  View+Extension.swift
//  Day 23-24 ViewsAndModifiers
//
//  Created by Gienadij Mackiewicz on 19/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    func watermaked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
    
    func blueFontStyle() -> some View {
        self.modifier(BlueFont())
    }
}
