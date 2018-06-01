//
//  Card.swift
//  2048-cf
//
//  Created by Liuliet.Lee on 31/5/2018.
//  Copyright © 2018 Liuliet.Lee. All rights reserved.
//

import Foundation

class Card {
    
    private var value: Int
    
    init(value: Int = 0) {
        self.value = value
    }
    
    func getValue() -> Int {
        return value
    }
    
    func upgrade() -> Int {
        value *= 2
        return value
    }
    
}
