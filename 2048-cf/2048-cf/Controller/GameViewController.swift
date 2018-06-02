//
//  GameViewController.swift
//  2048-cf
//
//  Created by Liuliet.Lee on 31/5/2018.
//  Copyright © 2018 Liuliet.Lee. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewDelegate {

    private let gameSize = 4
    
    private lazy var game = Game(size: gameSize)
    @IBOutlet weak var gameView: GameView! {
        didSet {
            gameView.size = gameSize
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameView.delegate = self
        game.start { (startCards) in
            gameView.performActions(startCards)
        }
    }
    
    func slideEnded(offset: CGPoint) {
        if game.status == .ended { return }
        let direction: Direction
        if offset.y > offset.x {
            if offset.y > -offset.x {
                direction = .down
            } else {
                direction = .left
            }
        } else {
            if offset.y > -offset.x {
                direction = .right
            } else {
                direction = .up
            }
        }
        game.move(to: direction) { (actions) in
            gameView.performActions(actions)
        }
    }

}
