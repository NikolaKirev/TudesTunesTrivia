//
//  StartQuizButton.swift
//  MusicQuizApp
//
//  Created by John Tudor on 26/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class StartQuizButton: UIButton {

    // It looks like this is not doing anything? maybe your idea was to call `setup()` here?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.size.height / 2
    }

    // Consider making theis private and calling it in `awakeFromNib`
    func setup() {
        backgroundColor = UIColor.ttReddishPink
    }
    
    
}
