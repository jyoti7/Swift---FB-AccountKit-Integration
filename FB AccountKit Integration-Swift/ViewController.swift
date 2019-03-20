//
//  ViewController.swift
//  FB AccountKit Integration-Swift
//
//  Created by MD ABDUR RAHMAN on 20/3/19.
//  Copyright © 2019 MD ABDUR RAHMAN. All rights reserved.
//

import UIKit
import AccountKit

class ViewController: UIViewController,AKFViewControllerDelegate {
    var accountKit: AKFAccountKit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //init Account Kit
        if accountKit == nil {
            self.accountKit = AKFAccountKit.init(responseType: .accessToken)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (accountKit.currentAccessToken != nil) {
            print("User already logged in, go to the home screen.")
            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

    func PrepareloginViewController(_loginViewController:AKFViewController)  {
        _loginViewController.delegate = self
        //_loginViewController.setAdvancedUIManager(nil)
        
        /*Basic theme with background*/
        
        _loginViewController.uiManager = AKFSkinManager(skinType: AKFSkinType.translucent, primaryColor: UIColor.orange, backgroundImage: UIImage(named: "mozahar_ios_logo.png"), backgroundTint: AKFBackgroundTint.black, tintIntensity: 0.70)
        
        _loginViewController.defaultCountryCode = "BD"
        /*
        //Customize the theme (Advance)
        let theme = AKFTheme.default()
        theme.headerBackgroundColor = UIColor(red: 0.4706, green: 0.7882, blue: 0, alpha: 1.0)
        theme.headerTextColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        theme.iconColor = UIColor(red: 0.749, green: 0, blue: 0.2235, alpha: 1.0)
        theme.inputTextColor = UIColor(white: 0.4, alpha: 1.0)
        theme.statusBarStyle = .default
        theme.textColor = UIColor(white: 0.3, alpha: 1.0)
        theme.titleColor = UIColor(red: 0.749, green: 0, blue: 0.2235, alpha: 1.0)
        _loginViewController.setTheme(theme)
       */
    }
    
    @IBAction func loginWithEmail(_ sender: Any) {
        //login with Email
        let inputState = UUID().uuidString
        let VC = accountKit.viewControllerForEmailLogin(withEmail: nil, state: inputState) as AKFViewController
        VC.enableSendToFacebook = true
        self.PrepareloginViewController(_loginViewController: VC)
        self.present(VC as! UIViewController, animated: true, completion: nil)
    }
    
    @IBAction func loginWithPhone(_ sender: UIButton) {
        //login with Phone
        let inputState = UUID().uuidString
        let VC = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as AKFViewController
        VC.enableSendToFacebook = true
        self.PrepareloginViewController(_loginViewController: VC)
        self.present(VC as! UIViewController, animated: true, completion: nil)
    }
    
}

