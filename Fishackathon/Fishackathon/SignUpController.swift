//
//  SignUpController.swift
//  iSports
//
//  Created by Susu Liang on 2017/12/19.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase
import KeychainSwift
import SCLAlertView

class SignUpController: UIViewController {

    let keyChain = KeychainSwift()

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameText: UITextField!

    @IBAction func signUp(_ sender: Any) {
        guard let email = emailText.text,
            let password = passwordText.text else {
            return
        }

        guard let name = nameText.text, !name.isEmpty else {
            SCLAlertView().showWarning("Error", subTitle: NSLocalizedString("Must enter name", comment: ""))
            return
        }

        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in

            if error != nil {
                if let errCode = AuthErrorCode(rawValue: error!._code) {

                    var message: String = ""

                    switch errCode {
                    case .invalidEmail:
                        message = NSLocalizedString("Invalid email", comment: "")
                    case .emailAlreadyInUse:
                        message = NSLocalizedString("Email already in use", comment: "")
                    case .weakPassword:
                        message = NSLocalizedString("Password should be greater than six digits", comment: "")
                    case .missingEmail:
                        message = NSLocalizedString("Must enter email", comment: "")

                    default:
                        print("Create User Error: \(error!)")

                    }
                    SCLAlertView().showWarning("Error", subTitle: message)
                    return
                }
            }

            guard let uid = user?.uid else {
                return
            }

            let ref = Database.database().reference()
            let userReference = ref.child("users").child(uid)
            let value = ["name": name, "email": email]
            userReference.updateChildValues(value, withCompletionBlock: {(err, ref) in
                if err != nil {
                    print(err)
                    return
                }

                self.keyChain.set(email, forKey: "email")
                self.keyChain.set(password, forKey: "password")
                self.keyChain.set(name, forKey: "name")
                self.keyChain.set(uid, forKey: "uid")

                let tabBarController = TabBarController(itemTypes: [ .market, .record])
                self.present(tabBarController, animated: true, completion: nil)
            })
        })
    }

    override func viewDidLoad() {
        keyChain.clear()
        super.viewDidLoad()
        view.layer.cornerRadius = 10

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
