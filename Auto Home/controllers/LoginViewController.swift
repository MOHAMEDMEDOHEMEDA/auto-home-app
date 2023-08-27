//
//  LoginViewController.swift
//  Auto Home
//
//  Created by Mohamed Magdy on 17/08/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    

    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
                if let email = emailTextField.text, let password = PasswordTextField.text {
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let e = error {
                        print(e)
                    }
                    else {
                    

                        self.performSegue(withIdentifier: "loginToMain", sender: self)

        
                    }
                }
            }
        }
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    

