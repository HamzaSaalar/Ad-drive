//
//  LoginViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 18/06/2022.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        let email = "qasim"
        let password = "123"
        let type = "1"
        
        
        let params = [
            "email"         : email,
            "password"      : password,
            "type"          : type
        ]
        
        
        ApiServices.CalAPIResponse(url: Endpoints.login, param: params, method: .post) { Response, success, ResponseError, ResponseCode in
            
            print(Response)
            
        }
        
        
        
        
        DispatchQueue.main.async {
            if let registrationVC : RegistrationVC = RegistrationVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(registrationVC, animated: true)
            }
        }
    }
    

}
