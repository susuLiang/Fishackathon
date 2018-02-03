//
//  SignController.swift
//  iSports
//
//  Created by Susu Liang on 2017/12/27.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase
import SCLAlertView

class LoginController: UIViewController {
    @IBOutlet weak var signInButton: UIButton!
    @IBAction func signInOrUp(_ sender: Any) {
        if !goSignUp {
            signInPage.isHidden = false
            signUpPage.isHidden = true
            signInButton.setTitle(NSLocalizedString("Sign up now", comment: ""), for: .normal)

            goSignUp = true
        } else {
            signInPage.isHidden = true
            signUpPage.isHidden = false
            signInButton.setTitle(NSLocalizedString("Back to sign in", comment: ""), for: .normal)

            goSignUp = false
        }
    }
    @IBOutlet weak var signUpPage: UIView!
    @IBOutlet weak var signInPage: UIView!
    var goSignUp = true

    override func viewDidLoad() {
        super.viewDidLoad()

        signInPage.isHidden = false
        signUpPage.isHidden = true
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
