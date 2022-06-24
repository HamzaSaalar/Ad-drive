//
//  ImagesViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 21/06/2022.
//

import UIKit

class ImagesViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        titleLabel.text = "hello."
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let allowLocationServicesVC : AllowLocationServicesVC = AllowLocationServicesVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(allowLocationServicesVC, animated: true)
            }
        }
    }
    
    

}
