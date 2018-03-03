//
//  ProfilePictureView.swift
//  MusicQuizApp
//
//  Created by John Tudor on 26/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class ProfilePictureImageView: UIImageView {

    // You could remove that. currently it's not doing anything.
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frame = CGRect(x: 275, y: 79, width: 50, height: 50)
        layer.cornerRadius = frame.size.height / 2;
        layer.masksToBounds = true
        layer.borderWidth = 0;
        contentMode = .scaleAspectFill
    }
}
