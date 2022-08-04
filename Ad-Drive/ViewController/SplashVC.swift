//
//  ViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 01/06/2022.
//

import UIKit
import ObjectMapper

class SplashVC: UIViewController {
    
    //MARK: - Properties
        
    @IBOutlet weak var mainView     : CustomView!
    @IBOutlet weak var nameLabel    : UILabel!
    
    var isAppStarted                = false
    var imagescreen                 = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let result = UserDefaults.standard.value(forKey: "loginUser") as? Data
        {
            do{
                //let json = try JSONSerialization.jsonObject(with: result, options: []) as? [String : Any]
                let jsonDecoder = JSONDecoder()
                let UserData = try jsonDecoder.decode(userDetailData.self, from: result)
                
                DataManager.shared.userData = UserData
                if UserData.carImagesUrl?.count ?? 0 == 0 {
                    self.imagescreen = true
                }
                self.isAppStarted = true
            } catch {
                print("erroMsg")
            }
        }
        if isAppStarted {
            // if not contain images then image screen //
            if imagescreen {
                DispatchQueue.main.async {
                    if let imagesViewController : ImagesViewController = ImagesViewController.instantiateViewControllerFromStoryboard() {
                        self.navigationController?.pushViewController(imagesViewController, animated: true)
                    }
                }
            } else { ///--->-->///////******** home screen ********///////      <---!****^^.-_-.^^^^^****!-->????^%^????<-->
                
                ///if location permission not allowed
                ///if !DataManager.shared.locationPermission()
                ///{
                ///DispatchQueue.main.async {
                ///if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllowLocationServicesVC") as? AllowLocationServicesVC {
                ///self.navigationController?.pushViewController(controller, animated: true)
                ///}
                ///}
                ///return
                ///}
                ///}
                
                DispatchQueue.main.async {
                    if let tabBarVC : TabBarVC = TabBarVC.instantiateViewControllerFromStoryboard() {
                        self.navigationController?.pushViewController(tabBarVC, animated: true)
                    }
                }
            }
        } else {
            navigateUserToAppropriateScreen()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //        if isAppStarted == true {
        //            navigateUserToAppropriateScreen()
        //        }
    }
    
    
    /**
     Redirect user from splash screen to walkThrough, Login/SignUp and Dashboard ViewController.
     
     - returns: void
     */
    @objc func navigateUserToAppropriateScreen() {
        
        // Set to true, can verify user redirected first time from splash screen.
        //        isAppStarted = true
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

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
