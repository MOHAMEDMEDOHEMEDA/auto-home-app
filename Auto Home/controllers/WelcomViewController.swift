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
    
  @IBOutlet weak var appLabel: UITextField!

    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {

      var window: UIWindow?

      func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
                       [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        return true
      }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let userNotificationCenter = UNUserNotificationCenter.current()
        userNotificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
        }
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appLabel.text = " "
        var charIndex = 0.0
        let label = "Auto Home"
        for litters in label{
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.appLabel.text?.append(litters)
            }
            charIndex += 1
        }
    }

    @IBAction func RegisterButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "welcomToRegister", sender: self)
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "welcomToLogin", sender: self)
    }
}

