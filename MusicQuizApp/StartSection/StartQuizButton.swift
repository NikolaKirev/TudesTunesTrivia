//
//  StartQuizButton.swift
//  MusicQuizApp
//
//  Created by John Tudor on 26/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class StartQuizButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }
    
    func setup() {
        backgroundColor = UIColor.ttReddishPink
    }
    
    
}
