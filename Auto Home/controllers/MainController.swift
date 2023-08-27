//
//  MainController.swift
//  Auto Home
//
//  Created by Mohamed Magdy on 21/08/2023.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth
import FirebaseFirestore




class MainController: UIViewController {
    @IBOutlet weak var homeSwitch: UISwitch!
    
    @IBOutlet weak var windowSwitch: UISwitch!
    @IBOutlet weak var roomSwitch: UISwitch!
    @IBOutlet weak var lightsSwitch: UISwitch!
    var convStatus = false
    let userNotificationCenter = UNUserNotificationCenter.current()


    var  result = false;
    var ref: DatabaseReference!
    let  user = Auth.auth().currentUser
    let db = Firestore.firestore()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        hackedOrNot()

        getButtonData("hoom door")
        getButtonData("room door")
        getButtonData("window")
        getButtonData("lights")
      

        

      
                    
           

    }
    @IBAction func homeDoorPressed(_ sender: UISwitch) {
//
        if sender.isOn {
            self.ref.child("users").child("hoom door").setValue(["hoom door": true])
        }
        else{
            self.ref.child("users").child("hoom door").setValue(["hoom door": false])
        }
    }
    @IBAction func roomPressed(_ sender: UISwitch) {
        if sender.isOn {
            self.ref.child("users").child("room door").setValue(["room door": true])

        }else{
            self.ref.child("users").child("room door").setValue(["room door": false])

        }
    }
    @IBAction func windowPressed(_ sender: UISwitch) {
        if sender.isOn {
            self.ref.child("users").child("window").setValue(["window": true])


        }else{
            self.ref.child("users").child("window").setValue(["window": false])

        
            
        }
    }
    @IBAction func lightsPressed(_ sender: UISwitch) {
        if sender.isOn {
            self.ref.child("users").child("lights").setValue(["lights": true])


        }else{
            self.ref.child("users").child("lights").setValue(["lights": false])

           
        }
    }
    
    @IBAction func sliderMoved(_ sender: UISlider) {
        
        self.ref.child("users").child("home door angle").setValue(["angle": sender.value])
        
    }
    @IBAction func seeSenorsPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "mainToSensors", sender: self)
    }
    func getButtonData(_ buttonType : String) {
        
        
        ref.child("users").child(buttonType).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let status = value?[buttonType]
           
            if status != nil {
                self.convStatus = Bool(truncating: status as! NSNumber )
                if buttonType == "room door"{
                    self.roomSwitch.setOn(self.convStatus, animated: true)
                }else if  buttonType == "hoom door"{
                    self.homeSwitch.setOn(self.convStatus, animated: true)
                }
                else if  buttonType == "window"{
                    self.windowSwitch.setOn(self.convStatus, animated: true)
                }
                else if  buttonType == "lights"{
                    self.lightsSwitch.setOn(self.convStatus, animated: true)
                }


            }
            else{
                print("nil value returned")
            }
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func hackedOrNot() {
        var hack = 0
        
        ref.child("notifications").observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    hack = value?["hack"] as? Int ?? 1
            if hack == 1{
                let alert = UIAlertController(title: "Notification", message: "!!! hacker detected !!!", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                let alert = UIAlertController(title: "Notification", message: "live in peace. ", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
    

}
