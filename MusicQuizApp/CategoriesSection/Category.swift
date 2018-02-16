//
//  Category.swift
//  MusicQuizApp
//
//  Created by John Tudor on 04/12/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit

class Categories {
    
    //MARK: Properties
    
    var name: String
    var image: UIImage
    
    //MARK: Initialization
    
    init?(name: String, image: UIImage) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.image = image
    }
}

