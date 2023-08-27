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

    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
        
        
        @IBAction func RegisterButtonPressed(_ sender: UIButton) {
            
            
            if let email = emailTextField.text, let password = PasswordTextField.text {
                Auth.auth().createUser(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password) { authResult, error in
                    if let e = error {
                        print(e)
                    } else {
                        //Navigate to the ChatViewController
                        self.performSegue(withIdentifier: "registerToMain", sender: self)
                        let alert = UIAlertController(title: "Notification", message: "user registerd in succesfully", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
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


