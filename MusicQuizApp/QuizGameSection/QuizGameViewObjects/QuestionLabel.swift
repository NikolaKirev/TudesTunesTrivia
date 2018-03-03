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
        // If your design supports it, consider using DynamicType. Will make it more accessible.
        // Something like:
        //
        // font = UIFont.preferredFont(forTextStyle: .headline)

        // If you want to have DynamicType and still specify the weight of the font:
        //
        // let pointSize = font.fontDescriptor.pointSize
        // font = UIFont.systemFont(ofSize: pointSize, weight: UIFont.Weight.regular)
    }
}
