//
//  LoginViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 18/06/2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var showHideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func ver(email : String?, password:String){
//        if email != ""{
//        }
//    }

    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        DispatchQueue.main.async {
            if let registrationVC : RegistrationVC = RegistrationVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(registrationVC, animated: true)
            }
        }
    }
    
    
    @IBAction func actionSignin(_ sender: Any) {
        
        
        if userNameField.text != "" || passwordField.text != "" {
            
            
            let params = [
                "email"         : self.userNameField.text ?? "",
                "password"      : self.passwordField.text ?? "",
                "type"          : "d"
            ]
            
            
            ApiServices.CalAPIResponse(url: Endpoints.login, param: params, method: .post) { responseVaue, successval, errorval, statusCode in
                
                if successval != nil {
                    print(responseVaue as Any)

                } else {
                    print(errorval?.localizedDescription ?? "")
                }
            }

        } else {
            print("Please fill both the fields")
        }
        
        
        
    }
    
    
    
    @IBAction func showPasswordPressed(_ sender: Any) {
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
        if passwordField.isSecureTextEntry {
            showHideButton.setImage(UIImage(systemName: "eye.slash") , for: .normal)
        } else {
            showHideButton.setImage(UIImage(systemName: "eye") , for: .normal)
        }
    }
    

}

extension LoginViewController : UITextFieldDelegate {
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userNameField{
            if range.location == 0 && string == " "{
                return false
            }
            if textField.text!.contains(" ") && string == " " {
                return false
            }
//            if range.location >= 11{
//                return false
//            }
           
        }
       
        
        else if textField == passwordField{
            if range.location >= 10{
                return false
            }
            else {
                return true
            }
        }
        return true
    }
    
}
