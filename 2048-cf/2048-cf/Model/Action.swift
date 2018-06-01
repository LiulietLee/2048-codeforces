//
//  Action.swift
//  2048-cf
//
//  Created by Liuliet.Lee on 31/5/2018.
//  Copyright © 2018 Liuliet.Lee. All rights reserved.
//

import Foundation

enum Action {
    case move(from: Position, to: Position)
    case upgrade(from: Position, to: Position, newValue: Int)
    case new(at: Position, value: Int)
}
