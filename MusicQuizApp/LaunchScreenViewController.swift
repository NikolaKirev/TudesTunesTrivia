//
//  LaunchScreenViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 12/02/2018.
//  Copyright © 2018 Jack Tudor. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController {
    
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
        let circleImageOne = UIImageView()
        let circleImageTwo = UIImageView()
        let circleImageThree = UIImageView()
        let circleImageFour = UIImageView()
        addBackgroundImage(backgroundImageView: circleImageOne, backgroundImage: #imageLiteral(resourceName: "circleGraphicOne"), position: CGRect(x: 304, y: 82, width: 142, height: 142))
        addBackgroundImage(backgroundImageView: circleImageTwo, backgroundImage: #imageLiteral(resourceName: "circleGraphicTwo"), position: CGRect(x: -216, y: 54, width: 431, height: 431))
        addBackgroundImage(backgroundImageView: circleImageThree, backgroundImage: #imageLiteral(resourceName: "circleGraphicOne"), position: CGRect(x: 160, y: 326, width: 431, height: 431))
        addBackgroundImage(backgroundImageView: circleImageFour, backgroundImage: #imageLiteral(resourceName: "circleGraphicTwo"), position: CGRect(x: -94, y: 570, width: 188, height: 188))
    }
    
    func addBackgroundImage(backgroundImageView: UIImageView, backgroundImage: UIImage, position: CGRect) {
        backgroundImageView.image = backgroundImage
        backgroundImageView.frame = position
        backgroundImageView.frame.size.height / 2
        view.addSubview(backgroundImageView)
    }

}
