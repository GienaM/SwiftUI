//
//  GridStack.swift
//  Day 23-24 ViewsAndModifiers
//
//  Created by Gienadij Mackiewicz on 19/10/2019.
//  Copyright © 2019 Gienadij Mackiewicz. All rights reserved.
//

import SwiftUI

struct GridStack<Content: View>: View {
    
    // MARK: - Properties
    
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    // MARK: - Initialization
    // This init makes an implicit horizontal stack for content closure using  @ViewBuilder attribute
    
    init(rows: Int,
         columns: Int,
         @ViewBuilder content: @escaping (Int, Int) -> Content) {
        
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
