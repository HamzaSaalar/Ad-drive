//
//  AllowLocationServicesVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit

class AllowLocationServicesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAlert()
    }
    

    func showAlert(){
        let alert = UIAlertController(title: "Allow “Ad-Drive” to use your location?", message: "To record your trips, Ad-Drive Automatically collects your location when you drive even when the app is in the background. If you only “Allow Once” access to your location, some features may not work while this app is in the background.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let allowMotionFitnessVC : AllowMotionFitnessVC = AllowMotionFitnessVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(allowMotionFitnessVC, animated: true)
            }
        }

    }
    
    
    
}
