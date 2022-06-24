//
//  ViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 01/06/2022.
//

import UIKit

class SplashVC: UIViewController {
    
    //MARK: - Properties
    var isAppStarted = false

    @IBOutlet weak var mainView: CustomView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAppStarted == false {
            perform(#selector(navigateUserToAppropriateScreen), with: nil, afterDelay: 3)
        } else {
            /* Redirect user to appropriate screen */
            self.navigateUserToAppropriateScreen()
        }
        
//        self.nameLabel.bringSubviewToFront(mainView)
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isAppStarted == true {
            navigateUserToAppropriateScreen()
        }
    }
    
    
    /**
     Redirect user from splash screen to walkThrough, Login/SignUp and Dashboard ViewController.
     
     - returns: void
     */
    @objc func navigateUserToAppropriateScreen() {
        
        // Set to true, can verify user redirected first time from splash screen.
        isAppStarted = true
        // Redirect user to login screen.
            self.redirectToLoginScreen()
        }
    
    func redirectToLoginScreen() {
        DispatchQueue.main.async {
            if let welcomeAppVC : WelcomeAppVC = WelcomeAppVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(welcomeAppVC, animated: true)
            }
        }
    }


}

