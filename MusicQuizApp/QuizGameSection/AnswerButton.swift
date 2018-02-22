//
//  AnswerButton.swift
//  MusicQuizApp
//
//  Created by John Tudor on 22/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        layer.borderWidth = 3
        let buttonBorderColor = UIColor(red: 186.0 / 255.0, green: 219.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
        layer.borderColor = buttonBorderColor.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height/2
    }
}
