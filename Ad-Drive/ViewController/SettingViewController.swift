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
    
    @IBAction func notificationPressed(_ sender: Any) {
        self.titleLabel.text = "hello"
    }
    
    //  resize the switches inside the view
    func layoutSwitch(){
        locationServicesSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        notificationSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        motionFitnessSwitch.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
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
