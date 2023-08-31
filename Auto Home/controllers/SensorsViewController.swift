//
//  SensorsViewController.swift
//  Auto Home
//
//  Created by Mohamed Magdy on 21/08/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import Firebase
import FirebaseFirestore




class SensorsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var lightsStatus: UILabel!
    @IBOutlet weak var windowStatus: UILabel!
    @IBOutlet weak var hoomDoorStatus: UILabel!
    @IBOutlet weak var roomDoorStatus: UILabel!
    
    @IBOutlet weak var doorAngle: UILabel!
    @IBOutlet weak var voltage: UILabel!
    
    @IBOutlet weak var ldrSensor: UILabel!
    @IBOutlet weak var rainSensor: UILabel!
    @IBOutlet weak var gasSensor: UILabel!
    
    // MARK: - Properties

    var convStatus = false
    var ref: DatabaseReference!
    let  user = Auth.auth().currentUser
    let db = Firestore.firestore()
    
    
    // MARK: - View Lifecycle

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        ref = Database.database().reference()
        getButtonData("hoom door")
        getButtonData("room door")
        getButtonData("window")
        getButtonData("lights")
        
        
        getSliderAngle("angle")
        
        
        
        
        getSensorsData("ldr_data")
        getSensorsData("gas_data")
        getSensorsData("rain_data")
        
        
        // if condition to detect if there is a gas in the air
        
        if (getGasSensor()>700){
            let alert = UIAlertController(title: "Notification", message: "there is a fire watch out!!! ", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Notification", message: "there is no fire", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
        
        
    }
    
    // MARK: - Helper Methods
    
    // function to get the buttons data from rtdb

    func getButtonData(_ buttonType : String) {
        
        
        ref.child("users").child(buttonType).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let status = value?[buttonType]
            self.convStatus = Bool(truncating: status as! NSNumber)
            if buttonType == "room door"{
                self.roomDoorStatus.text = self.convStatus ? "open" : "close"
                
            }else if  buttonType == "hoom door"{
                self.hoomDoorStatus.text =  self.convStatus ? "open" : "close"
            }
            else if  buttonType == "window"{
                self.windowStatus.text =  self.convStatus ? "open" : "close"
            }
            else if  buttonType == "lights"{
                self.lightsStatus.text =  self.convStatus ? "open" : "close"
            }
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // function to get the slider angle  from rtdb

    func getSliderAngle(_ angle: String){
        ref.child("users").child("home door angle").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let status = value?[angle] as? Float
            let doorAngle = status
            if doorAngle != nil{
                self.doorAngle.text = String(format: "%.f", doorAngle!)
            }
            else{
                print("door angle is nil")
            }
            
            
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    // function to get sensors readings from our smart home
    
    func getSensorsData(_ sensorType : String) {
        var sensorResult = 0
        
        ref.child("Sensor").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            sensorResult = value?[sensorType] as? Int ?? 0
            if sensorType == "gas_data"{
                self.gasSensor.text = String(sensorResult)
                
            }else if  sensorType == "ldr_data"{
                self.ldrSensor.text = String(sensorResult)
            }
            else if  sensorType == "rain_data"{
                self.rainSensor.text = String(sensorResult)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    // function to get only gas sensor readings from our smart home

    func getGasSensor () -> Int{
        
        var sensorResult = 0
        
        ref.child("Sensor").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            sensorResult = value?["gas_data"] as? Int ?? 700
            print(sensorResult)
            
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
        return sensorResult
    }
}
    



