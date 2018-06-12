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
    
    private var cards = [[CardView]]()
    private var canMove = true
    private var touchingDetectable = true
    var size: Int = 0
    var skin: AbstractSkin = ClassicSkin()
    
    private let margin: CGFloat = 5.0
    private var drawBound: CGRect {
        var bound = self.bounds
        bound.origin.x += margin; bound.origin.y += margin
        bound.size.width -= margin * 2; bound.size.height -= margin * 2
        return bound
    }
    private var boundSize: CGFloat {
        let viewWidth = drawBound.size.width
        return viewWidth / CGFloat(size)
    }
    private var cardSize: CGSize {
        return CGSize(width: boundSize - margin * 2, height: boundSize - margin * 2)
    }
    private var startLocation = CGPoint()
    
    private func getRectOf(row: Int, col: Int) -> CGRect {
        var location = CGPoint(x: CGFloat(col) * boundSize, y: CGFloat(row) * boundSize)
        location.x += margin + drawBound.origin.x
        location.y += margin + drawBound.origin.y
        return CGRect(origin: location, size: cardSize)
    }
    
    override func layoutSubviews() {
        cards = []
        for row in 0..<size {
            cards.append([])
            for col in 0..<size {
                let newCardView = CardView(
                    frame: getRectOf(row: row, col: col),
                    value: 0,
                    skin: skin
                )
                cards[row].append(newCardView)
                self.addSubview(cards[row][col])
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        UIColor(red:0.80, green:0.75, blue:0.71, alpha:1.00).setFill()
        for row in 0..<size {
            for col in 0..<size {
                let rect = UIBezierPath(
                    roundedRect: getRectOf(row: row, col: col),
                    cornerRadius: 10.0
                )
                rect.fill()
            }
        }
    }
    
    func performActions(_ actions: [Action]) {
        actions.forEach {
            switch $0 {
            case .new(let position, let newValue):
                newCard(at: position, withValue: newValue)
            case .move(let from, let to):
                moveCard(from: from, to: to)
            case .upgrade(let from, let to, let newValue):
                upgrade(from: from, to: to, newValue: newValue)
            default:
                break
            }
        }
        canMove = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(250)) {
            self.canMove = true
        }
    }
    
    private func newCard(at position: Position, withValue newValue: Int) {
        cards[position.row][position.col].flash(withValue: newValue)
    }
    
    private func moveCard(from: Position, to: Position) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.04 * Double((max(abs(from.row - to.row), abs(from.col - to.col)))),
            delay: 0,
            options: [],
            animations: {
                self.cards[from.row][from.col].frame.origin = self.getRectOf(row: to.row, col: to.col).origin
                self.cards[to.row][to.col].frame = self.getRectOf(row: from.row, col: from.col)
            }
        )
        
        let tempCard = cards[from.row][from.col]
        cards[from.row][from.col] = cards[to.row][to.col]
        cards[to.row][to.col] = tempCard
    }
    
    private func upgrade(from: Position, to: Position, newValue: Int) {
        cards[to.row][to.col].updateValue(to: 0)
        moveCard(from: from, to: to)
        newCard(at: to, withValue: newValue)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startLocation = touch.preciseLocation(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !canMove || !touchingDetectable {
            return
        }
        if let touch = touches.first {
            let endLocation = touch.preciseLocation(in: self)
            if distance(between: endLocation, and: startLocation) > 50 {
                touchingDetectable = false
                let offset = endLocation - startLocation
                delegate?.slideEnded(offset: offset)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchingDetectable = true
    }
    
    private func distance(between pointA: CGPoint, and PointB: CGPoint) -> Double {
        return sqrt(Double((pointA.x - PointB.x) * (pointA.x - PointB.x) + (pointA.y - PointB.y) * (pointA.y - PointB.y)))
    }
    
}

extension CGPoint {
    public static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
