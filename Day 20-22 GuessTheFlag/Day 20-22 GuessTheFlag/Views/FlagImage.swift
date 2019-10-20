//
//  FlagImage.swift
//  Day 20-22 GuessTheFlag
//
//  Created by Gienadij Mackiewicz on 20/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name).renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}
