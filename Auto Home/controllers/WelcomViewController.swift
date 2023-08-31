//
//  ViewController.swift
//  Auto Home
//
//  Created by Mohamed Magdy on 17/08/2023.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseFirestore

class WelcomViweController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var appLabel: UITextField!
    
    // MARK: - View Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Request user notification permissions
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
        }
        
        // Hide navigation bar
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show navigation bar
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set initial text for appLabel
        appLabel.text = " "
        
        var charIndex = 0.0
        let label = "Auto Home"
        
        // Animate the appLabel text by adding each letter with a delay
        for letter in label {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.appLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    // MARK: - IBActions
    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        // Perform segue to registration view
        performSegue(withIdentifier: "welcomToRegister", sender: self)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        // Perform segue to login view
        performSegue(withIdentifier: "welcomToLogin", sender: self)
    }
}
