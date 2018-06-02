//
//  GameView.swift
//  2048-cf
//
//  Created by Liuliet.Lee on 31/5/2018.
//  Copyright © 2018 Liuliet.Lee. All rights reserved.
//

import UIKit

protocol GameViewDelegate {
    func slideEnded(offset: CGPoint)
}

class GameView: UIView {
    
    var delegate: GameViewDelegate? = nil
    var size: Int = 0
    private let margin: CGFloat = 5.0
    private var boundSize: CGFloat {
        let viewWidth = self.bounds.size.width
        return viewWidth / CGFloat(size)
    }
    private var cardSize: CGSize {
        return CGSize(width: boundSize - margin * 2, height: boundSize - margin * 2)
    }
    private var startLocation = CGPoint()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func draw(_ rect: CGRect) {
        UIColor(red:0.80, green:0.75, blue:0.71, alpha:1.00).setFill()
        for row in 0..<size {
            for col in 0..<size {
                var location = CGPoint(x: CGFloat(col) * boundSize, y: CGFloat(row) * boundSize)
                location.x += margin; location.y += margin
                let rect = UIBezierPath(
                    roundedRect: CGRect(origin: location, size: cardSize),
                    cornerRadius: 10.0
                )
                rect.fill()
            }
        }
    }
    
    func performActions(_ actions: [Action]) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startLocation = touch.preciseLocation(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let endLocation = touch.preciseLocation(in: self)
            let offset = endLocation - startLocation
            delegate?.slideEnded(offset: offset)
        }
    }
    
}

extension CGPoint {
    public static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
