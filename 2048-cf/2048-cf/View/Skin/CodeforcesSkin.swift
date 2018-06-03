//
//  CodeforcesSkin.swift
//  2048-cf
//
//  Created by Liuliet.Lee on 3/6/2018.
//  Copyright © 2018 Liuliet.Lee. All rights reserved.
//

import UIKit

class CodeforcesSkin: AbstractSkin {
    
    override var sheet: [Int : Style] {
        return [
            2   : Style(content: "Newb.", labelColor: .darkGray, backgroundColor: UIColor(red:0.817, green:0.817, blue:0.817, alpha:1.00)),
            4   : Style(content: "Pupil", labelColor: .white, backgroundColor: UIColor(red:0, green:0.5, blue:0, alpha:1.00)),
            8   : Style(content: "Spec.", labelColor: .white, backgroundColor: UIColor(red:0.008, green:0.66, blue:0.62, alpha:1.00)),
            16  : Style(content: "Expe.", labelColor: .white, backgroundColor: UIColor(red:0, green:0, blue:1, alpha:1.00)),
            32  : Style(content: "CMtr", labelColor: .white, backgroundColor: UIColor(red:0.66, green:0, blue:0.66, alpha:1.00)),
            64  : Style(content: "Mastr", labelColor: .white, backgroundColor: UIColor(red:1, green:0.55, blue:0, alpha:1.00)),
            128 : Style(content: "IMtr", labelColor: .white, backgroundColor: UIColor(red:1, green:0.55, blue:0, alpha:1.00)),
            256 : Style(content: "GMtr", labelColor: .darkGray, backgroundColor: UIColor(red:1, green:0.78, blue:0.78, alpha:1.00)),
            512 : Style(content: "IGM", labelColor: .white, backgroundColor: UIColor(red:1, green:0.2, blue:0.2, alpha:1.00)),
            1024: Style(content: "LGM", labelColor: .white, backgroundColor: UIColor(red:0.67, green:0, blue:0, alpha:1.00))
        ]
    }
    
}
