//
//  WelcomeAppVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit

class WelcomeAppVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any)
    {
        DispatchQueue.main.async {
            if let conditionsViewController : ConditionsViewController = ConditionsViewController.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(conditionsViewController, animated: true)
            }
        }
    }
}
