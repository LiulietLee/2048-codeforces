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
            gameView.skin = CodeforcesSkin()
        }
    }
    private var maskView: UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0.0
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.game.goal = 1024
        gameView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.startGame()
        }
    }
    
    private func startGame() {
        self.game.start { (startCards) in
            self.gameView.performActions(startCards)
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
            if let last = actions.last {
                switch last {
                case .failure:
                    showFailureView()
                    game.status = .ended
                case .success:
                    showSuccessView()
                    game.status = .ended
                default: break
                }
            }
        }
    }
    
    private func showMaskView(_ mask: UIView) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.5,
            delay: 0.0,
            options: [],
            animations: {
                mask.alpha = 0.2
            }
        )
    }
    
    @objc private func maskViewDisappear(_ sender: UIButton) {
        if let view = sender.superview {
            UIViewPropertyAnimator.runningPropertyAnimator(
                withDuration: 0.5,
                delay: 0.0,
                options: [],
                animations: {
                    view.alpha = 0.0
                }
            ) { position in
                view.removeFromSuperview()
                self.startGame()
            }
        }
    }
    
    private func getMaskTitleLabel(withText text: String) -> UILabel {
        let title = UILabel()
        title.text = text
        title.font = UIFont.boldSystemFont(ofSize: 36.0)
        title.textColor = .darkGray
        title.numberOfLines = 0
        title.textAlignment = .center
        return title
    }
    
    private func getMaskButton(withTitle title: String, andSelector selector: Selector) -> UIButton {
        let backButton = UIButton()
        backButton.setTitle(title, for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = .orange
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 10.0
        backButton.addTarget(self, action: selector, for: .touchUpInside)
        return backButton
    }
    
    private func configMaskView(_ mask: inout UIView, byTitleLabel title: UILabel, andButton button: UIButton) {
        mask.addSubview(button)
        mask.addSubview(title)
        view.addSubview(mask)
        view.bringSubview(toFront: mask)
        
        mask.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mask.topAnchor.constraint(equalTo: view.topAnchor),
            mask.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mask.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mask.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            title.topAnchor.constraint(equalTo: mask.topAnchor, constant: 50),
            title.centerXAnchor.constraint(equalTo: mask.centerXAnchor),
            title.leadingAnchor.constraint(equalTo: mask.leadingAnchor, constant: 200),
            
            button.centerXAnchor.constraint(equalTo: mask.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: mask.centerYAnchor, constant: 300)
        ])
    }
    
    private func showSuccessView() {
        let title = getMaskTitleLabel(withText: "You got Legendary grandmaster wow!")
        let backButton = getMaskButton(withTitle: "Try Again", andSelector: #selector(maskViewDisappear(_ :)))
        var mask = maskView
        configMaskView(&mask, byTitleLabel: title, andButton: backButton)
        showMaskView(mask)
    }
    
    private func showFailureView() {
        let title = getMaskTitleLabel(withText: "Game Over!")
        let backButton = getMaskButton(withTitle: "Try Again", andSelector: #selector(maskViewDisappear(_ :)))
        var mask = maskView
        configMaskView(&mask, byTitleLabel: title, andButton: backButton)
        showMaskView(mask)
    }

}
