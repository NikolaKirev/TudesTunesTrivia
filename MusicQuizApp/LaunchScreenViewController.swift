//
//  LaunchScreenViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 12/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    @IBOutlet weak var circleImageFour: UIImageView!
    @IBOutlet weak var circleImageThree: UIImageView!
    @IBOutlet weak var circleImageOne: UIImageView!
    @IBOutlet weak var circleImageTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGraphics()
        view.backgroundColor = UIColor(red: 53.0 / 255.0, green: 57.0 / 255.0, blue: 154.0 / 255.0, alpha: 1.0)
        perform(#selector(self.showMainMenu), with: nil, afterDelay: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func showMainMenu() {
        performSegue(withIdentifier: "mainmenu", sender: self)
    }
    
    func setGraphics() {
        circleImageOne.image = #imageLiteral(resourceName: "circleGraphicOne")
        circleImageTwo.image = #imageLiteral(resourceName: "circleGraphicTwo")
        circleImageThree.image = #imageLiteral(resourceName: "circleGraphicOne")
        circleImageFour.image = #imageLiteral(resourceName: "circleGraphicTwo")
    }

}
