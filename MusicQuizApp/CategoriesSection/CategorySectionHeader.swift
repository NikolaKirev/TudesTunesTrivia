//
//  CategorySectionHeader.swift
//  MusicQuizApp
//
//  Created by John Tudor on 16/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class CategorySectionHeader: UICollectionReusableView {
    
    internal static let viewHeight: CGFloat = 81
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
