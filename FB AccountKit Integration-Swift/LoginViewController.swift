//
//  LoginViewController.swift
//  FB AccountKit Integration-Swift
//
//  Created by MD ABDUR RAHMAN on 20/3/19.
//  Copyright © 2019 MD ABDUR RAHMAN. All rights reserved.
//

import UIKit
import AccountKit

fileprivate func > <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default: return rhs < lhs
    }
}

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

class LoginViewController: UIViewController {
   var accountKit: AKFAccountKit!
    @IBOutlet weak var phoneOrEmail: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var accountIdLbl: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        //Init Account Kit
        if accountKit == nil {
            self.accountKit = AKFAccountKit(responseType: .accessToken)
            
            accountKit.requestAccount({ (account, error) in
                self.accountIdLbl.text = account?.accountID
                if (account?.emailAddress?.characters.count) > 0 {
                    //if the user is logged with Email
                    self.typeLbl.text = "Email Address"
                    self.phoneOrEmail.text = account!.emailAddress
                    //if the user is logged with Phone
                } else if account?.phoneNumber?.phoneNumber != nil {
                    self.typeLbl.text = "Phone Number"
                    self.phoneOrEmail.text = account!.phoneNumber?.stringRepresentation()
                }
            })
        }
        
    }
    



    @IBAction func logout(_ sender: UIButton) {
        accountKit.logOut()
        dismiss(animated: true, completion: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
}
