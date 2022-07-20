//
//  SettingViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 20/06/2022.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var locationServicesSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var motionFitnessSwitch: UISwitch!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // resize the switches inside the view
        layoutSwitch()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    @IBAction func notificationPressed(_ sender: Any) {
        self.titleLabel.text = "hello"
    }
    
    //  resize the switches inside the view
    func layoutSwitch(){
        locationServicesSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        notificationSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        motionFitnessSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    
    func setupView()
    {
        // location service
        if DataManager.shared.locationPermission()
        {
            locationServicesSwitch.isOn = true
        } else {
            locationServicesSwitch.isOn = false
        }
        
        // notification
        if DataManager.shared.checkNotificationsEnabled() {
            notificationSwitch.isOn = true
        } else {
            notificationSwitch.isOn = false
        }
        
        // motion
        if DataManager.shared.checkMotionPermission() {
            motionFitnessSwitch.isOn = true
        } else {
            motionFitnessSwitch.isOn = false
        }
    }
    
    
    @IBAction func switchLocation(_ sender: Any)
    {
        
        var message = "Do you want to enable location permission"
        
        if !DataManager.shared.locationPermission()
        {
            message = "Do you want to disable location permission"
        }

        let alertController = UIAlertController(title: "Location Alert", message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func notificationSwitch(_ sender: Any)
    {
        
    }
    
    @IBAction func motionSwitch(_ sender: Any)
    {
        
    }
    

}
