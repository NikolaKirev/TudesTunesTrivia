//
//  HomeButton.swift
//  MusicQuizApp
//
//  Created by John Tudor on 23/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class HomeButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = 5.0
    }
    
    private func setup() {
        backgroundColor = UIColor.ttReddishPink
    }
}
