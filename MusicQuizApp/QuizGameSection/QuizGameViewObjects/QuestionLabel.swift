//
//  QuestionLabel.swift
//  MusicQuizApp
//
//  Created by John Tudor on 22/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class QuestionLabel: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        font = UIFont.systemFont(ofSize: 23.0, weight: .regular)
    }
}
