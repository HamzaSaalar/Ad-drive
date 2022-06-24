//
//  AllowNotificationVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit

class AllowNotificationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showAlert()
    }
    
    
    func showAlert(){
        let alert = UIAlertController(title: "“Ad-Drive” would like to send you notifications.", message: "Notifications may include alerts, sounds and icon badges. These can be configured in settings", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Don't Allow", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }

    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            if let finishInformationVC : FinishInformationVC = FinishInformationVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(finishInformationVC, animated: true)
            }
        }

    }

}
