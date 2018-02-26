//
//  LaunchViewController.swift
//  MusicQuizApp
//
//  Created by John Tudor on 30/11/2017.
//  Copyright © 2017 Jack Tudor. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class StartMenuViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var profilePicture: ProfilePictureImageView!
    @IBOutlet weak var startQuizButton: StartQuizButton!
    
    var loginButton: LoginButton = LoginButton(readPermissions: [.publicProfile])
    
    var dict: [String: AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ttBlueberry
        startButtonProperties()
        facebookLoginProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButton.isHidden = (FBSDKAccessToken.current()) != nil
        getFBUserData()
    }
    
    func facebookLoginProperties() {
        loginButton.center = view.center
        view.addSubview(loginButton)
        if (FBSDKAccessToken.current()) != nil {
            getFBUserData()
        }
    }
    
    func startButtonProperties() {
        let button = startQuizButton
        button?.backgroundColor = UIColor.ttReddishPink
        button?.clipsToBounds = true
        button?.layer.cornerRadius = 5.0
    }
    
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile, .userFriends], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                self.getFBUserData()
            }
        }
    }
    
    func getFBUserData() {
        if ((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection,  result, error) -> Void in
                if (error == nil) {
                    guard let data = result as? [String:Any] else { return }
                    let fbid = data["id"]
                    let name = data["name"] as? String 
                    self.userNameLabel.text = "\(name!)"
                    let url = URL(string: "https://graph.facebook.com/\(fbid!)/picture?type=large&return_ssl_resources=1")
                    do {
                        try! self.profilePicture.image = UIImage(data: NSData(contentsOf: url!) as Data)
                    }
                }
            })
        } else {
            print("Token is still valid")
        }
    }
}
