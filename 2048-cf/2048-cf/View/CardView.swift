//
//  CardView.swift
//  2048-cf
//
//  Created by Liuliet.Lee on 1/6/2018.
//  Copyright © 2018 Liuliet.Lee. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    private let label = UILabel()

    init(frame: CGRect, value: Int) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .orange
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
        set(value: value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func set(value: Int) {
        // TODO: - modfiy by skin
        updateValue(to: value)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: label.font.fontName, size: 36.0)
        label.minimumScaleFactor = 0.5
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
    
    func updateValue(to newValue: Int) {
        if newValue == 0 {
            self.isHidden = true
        } else {
            self.isHidden = false
            label.text = String(newValue)
        }
    }
    
    func flash(withValue value: Int = 0) {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 0.0,
            delay: 0.1,
            options: [],
            animations: {
                self.transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
            },
            completion: { position in
                self.updateValue(to: value)
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.2,
                    delay: 0.0,
                    options: [.repeat],
                    animations: {
                        self.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
                    }, completion: { position in
                        self.transform = .identity
                    }
                )
            }
        )
    }

}
