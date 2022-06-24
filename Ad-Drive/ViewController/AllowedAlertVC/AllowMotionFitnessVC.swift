//
//  AllowMotionFitnessVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit

class AllowMotionFitnessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAlert()
    }
    

    func showAlert(){
        let alert = UIAlertController(title: "“Ad-Drive” would like to access your Motion & Fitness activity", message: "Ad-Drive needs to access motion data to improve drive detection accuracy", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let allowNotificationVC : AllowNotificationVC = AllowNotificationVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(allowNotificationVC, animated: true)
            }
        }
    }
    

}
