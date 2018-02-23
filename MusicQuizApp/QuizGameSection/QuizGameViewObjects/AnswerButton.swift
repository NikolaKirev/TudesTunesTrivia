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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height/2
    }
    
    private func setup() {
        layer.borderWidth = 2
        let buttonBorderColor = UIColor.ttPowderBlue
        layer.borderColor = buttonBorderColor.cgColor
        backgroundColor = UIColor.white
    }
}
