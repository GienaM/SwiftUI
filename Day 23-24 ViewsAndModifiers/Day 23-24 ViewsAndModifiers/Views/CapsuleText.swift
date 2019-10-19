//
//  CapsuleText.swift
//  Day 23-24 ViewsAndModifiers
//
//  Created by Gienadij Mackiewicz on 19/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}
