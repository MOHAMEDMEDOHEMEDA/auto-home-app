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
    
    // MARK: - IBOutlets
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        // Retrieve email and password from text fields
        if let email = emailTextField.text, let password = PasswordTextField.text {
            // Sign in with Firebase Auth
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    // Login failed, print error
                    print(e)
                } else {
                    // Login successful, navigate to the Main view
                    self.performSegue(withIdentifier: "loginToMain", sender: self)
                }
            }
        }
    }
}
