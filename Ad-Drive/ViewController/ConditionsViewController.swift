//
//  ConditionsViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 16/06/2022.
//

import UIKit

class ConditionsViewController: UIViewController {
    
    @IBOutlet weak var titleLLabel          : UILabel!
    @IBOutlet weak var checkFirstImage      : UIImageView!
    @IBOutlet weak var checkSecondImage     : UIImageView!
    @IBOutlet weak var checkThirdImage      : UIImageView!
    @IBOutlet weak var checkFourthImage     : UIImageView!
    @IBOutlet weak var firstHideView        : UIView!
    @IBOutlet weak var secondHideView       : CustomView!
    @IBOutlet weak var thirdHideView        : UIView!
    @IBOutlet weak var fourthHideView       : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    @IBAction func checkFirstPressed(_ sender: Any) {
        if firstHideView.isHidden {
            firstHideView.isHidden  = false
            checkFirstImage.image   = UIImage(named: "icon_awesome_check")
        } else {
            firstHideView.isHidden  = true
            checkFirstImage.image   = UIImage(named: "rectangle_3")
        }
    }
    @IBAction func checkSecondPressed(_ sender: Any) {
        if secondHideView.isHidden {
            secondHideView.isHidden = false
            checkSecondImage.image  = UIImage(named: "icon_awesome_check")
        } else {
            secondHideView.isHidden = true
            checkSecondImage.image  = UIImage(named: "rectangle_3")
        }
    }
    @IBAction func checkThirdPressed(_ sender: Any) {
        if thirdHideView.isHidden {
            thirdHideView.isHidden  = false
            checkThirdImage.image   = UIImage(named: "icon_awesome_check")
        } else {
            thirdHideView.isHidden  = true
            checkThirdImage.image   = UIImage(named: "rectangle_3")
        }
    }
    
    @IBAction func checkFourthPressed(_ sender: Any) {
        if fourthHideView.isHidden {
            fourthHideView.isHidden = false
            checkFourthImage.image  = UIImage(named: "icon_awesome_check")
        } else {
            fourthHideView.isHidden = true
            checkFourthImage.image  = UIImage(named: "rectangle_3")
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let registrationVC : RegistrationVC = RegistrationVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(registrationVC, animated: true)
            }
        }
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let loginViewController : LoginViewController = LoginViewController.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
        }
    }
}
