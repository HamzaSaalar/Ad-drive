//
//  RegistrationVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit

class RegistrationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let imagesViewController : ImagesViewController = ImagesViewController.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(imagesViewController, animated: true)
            }
        }
    }
}
