//
//  RegisterViewController.swift
//  Auto Home
//
//  Created by Mohamed Magdy on 17/08/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        // Retrieve email and password from text fields
        if let email = emailTextField.text, let password = PasswordTextField.text {
            // Create user using Firebase Auth
            Auth.auth().createUser(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password) { authResult, error in
                if let e = error {
                    // Registration failed, print error
                    print(e)
                } else {
                    // Registration successful, navigate to the Main view
                    self.performSegue(withIdentifier: "registerToMain", sender: self)
                    
                    // Display success alert
                    let alert = UIAlertController(title: "Notification", message: "User registered successfully", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
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
}
