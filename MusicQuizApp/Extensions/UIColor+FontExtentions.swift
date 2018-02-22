//
//  UIColor+FontExtentions.swift
//  MusicQuizApp
//
//  Created by John Tudor on 12/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    public class var ttBlueberry: UIColor {
        return UIColor(red: 53.0 / 255.0, green: 57.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
    }
    
    public class var ttReddishPink: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 33.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    }
    
    public class var ttPowderBlue: UIColor {
        return UIColor(red: 186.0 / 255.0, green: 219.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    public class var ttWeirdGreen: UIColor {
        return UIColor(red: 86.0 / 255.0, green: 233.0 / 255.0, blue: 158.0 / 255.0, alpha: 1.0)
    }
    
    public class var ttRedOrange: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 53.0 / 255.0, blue: 4.0 / 255.0, alpha: 1.0)
    }
}

// Sample text styles

extension UIFont {
    
    @nonobjc class var ttHeader: UIFont {
        return UIFont.systemFont(ofSize: 24.0, weight: .semibold)
    }
    
    @nonobjc class var ttNormal: UIFont {
        return UIFont.systemFont(ofSize: 16.0, weight: .medium)
    }
}
