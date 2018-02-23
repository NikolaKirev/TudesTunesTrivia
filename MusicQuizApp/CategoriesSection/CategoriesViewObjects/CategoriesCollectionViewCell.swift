//
//  CategoriesCollectionViewCell.swift
//  MusicQuizApp
//
//  Created by John Tudor on 03/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 7.0
        categoryName.font = .systemFont(ofSize: 25.0, weight: .heavy)
        categoryName.textColor = .white
        categoryName.lineBreakMode = .byWordWrapping
    }
    
    func configure(with category: Category) {
        categoryImage.image = category.image
        categoryName.text = category.name
    }
    
}
