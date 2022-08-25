//
//  ChangePasswordController.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 04/08/2022.
//

import UIKit

class ChangePasswordController: UIViewController {

    @IBOutlet weak var textFieldPassword            : UITextField!
    @IBOutlet weak var textFieldConfirmPassword     : UITextField!
    @IBOutlet weak var textFieldCurrentPassword     : UITextField!
    
    @IBOutlet weak var buttonShowPassword           : UIButton!
    @IBOutlet weak var buttonShowConfirmPassword    : UIButton!
    @IBOutlet weak var buttonShowCurrentPassword    : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func ActionShowPassword(_ sender: Any)
    {
        
    }
    
    @IBAction func ActionShowConfirmPassword(_ sender: Any)
    {
        
    }
    
    @IBAction func ActionShowCurrentPassword(_ sender: Any)
    {

        if textFieldCurrentPassword.text ?? "" != "" {
            DataManager.Alertbox(message: "Please enter current password", vc: self)
            return
        }
        
        if textFieldCurrentPassword.text ?? "" != DataManager.shared.userData?.password ?? ""{
            DataManager.Alertbox(message: "Current password is not matching", vc: self)
            return
        }
        
        if textFieldPassword.text ?? "" != "" {
            DataManager.Alertbox(message: "Please enter password", vc: self)
            return
        }
        
        
        if textFieldConfirmPassword.text ?? "" != "" {
            DataManager.Alertbox(message: "Please enter confirm password", vc: self)
            return
        }
        
        if textFieldCurrentPassword.text ?? "" != textFieldConfirmPassword.text ?? "" {
            DataManager.Alertbox(message: "Password and confirm password are not same", vc: self)
            return
        }
        
        let params = [
            "password" : textFieldPassword.text ?? ""
        ]
        
        ApiServices.CalAPIResponse(url: "", param: params, method: .post) { response, success, Error, StatusCode in
            
            if success ?? false {
                
            }
        }
        
        
    }
    
    @IBAction func ActionChangePassword(_ sender: Any)
    {
        
    }
    
    @IBAction func ActionBack(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
}
