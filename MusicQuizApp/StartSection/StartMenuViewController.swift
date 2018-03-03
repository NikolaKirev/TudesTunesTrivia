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

// If you don't plan to subclass StartMenuViewController you could make it `final`.
// That will prevent subclassing. Subclassing is a grat tool to have but in Swift we can use protocols to share behaviour.
// That tends to be more scalable that subclassing.
class StartMenuViewController: UIViewController {

    // You could make most or all of your IBOutlest private. Interface builder will still "see" them but other object will not be able to interact wit hthem and cause side effects.
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

    // consider making private
    func facebookLoginProperties() {
        loginButton.center = view.center
        view.addSubview(loginButton)
        if (FBSDKAccessToken.current()) != nil {
            getFBUserData()
        }
    }
    // consider making private
    func startButtonProperties() {
        let button = startQuizButton
        button?.backgroundColor = UIColor.ttReddishPink // you could move these to the button `setup()` and call it from `awakeFromNib`
        button?.clipsToBounds = true
        button?.layer.cornerRadius = 5.0
    }

    // consider making private
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
  
    // consider making private
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
