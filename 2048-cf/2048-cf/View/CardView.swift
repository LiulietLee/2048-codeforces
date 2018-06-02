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

    func set(value: Int) {
        // TODO: - modfiy by skin
        updateValue(to: value)
        label.textColor = .white
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leftAnchor.constraint(equalTo: self.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
        self.backgroundColor = .orange
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10.0
    }
    
    func updateValue(to newValue: Int) {
        label.text = newValue == 0 ? "" : String(newValue)
    }
    
    func flash() {
        // TODO: - flash animation
        print("kira~ kira~")
    }
    
}
