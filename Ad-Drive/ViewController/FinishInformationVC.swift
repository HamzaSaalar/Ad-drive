//
//  FinishInformationVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit

class FinishInformationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let tabBarVC : TabBarVC = TabBarVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(tabBarVC, animated: true)
            }
        }

    }
    

}
