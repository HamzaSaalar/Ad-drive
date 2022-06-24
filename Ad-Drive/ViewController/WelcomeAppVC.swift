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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let conditionsViewController : ConditionsViewController = ConditionsViewController.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(conditionsViewController, animated: true)
            }
        }
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
