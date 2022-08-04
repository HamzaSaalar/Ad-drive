//
//  RegistrationVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit
import ObjectMapper
import KRProgressHUD

struct carRegister          : Codable {
    
    let id                  : Int?
    //let imagesUrl         : [String]?
    let make                : String?
    let model               : String?
    let registrationNumber  : String?
}

struct responseModelRegister    : Codable {
    
    let car                     : carRegister?
    let dob                     : String?
    let driverNumber            : String?
    let driverToken             : String?
    let email                   : String?
    let firstName               : String?
    let id                      : Int?
    let lastName                : String?
    let password                : String?
    
}

class RegistrationVC: UIViewController {

    @IBOutlet weak var firstNameField           : UITextField!
    @IBOutlet weak var lastNameField            : UITextField!
    @IBOutlet weak var doBirthField             : UITextField!
    @IBOutlet weak var emailField               : UITextField!
    @IBOutlet weak var createPasswordField      : UITextField!
    
    @IBOutlet weak var createPasswordHidden     : UIButton!
    @IBOutlet weak var varifyPasswordHidden     : UIButton!
    
    @IBOutlet weak var varifyPasswordField      : UITextField!
    @IBOutlet weak var vehicleMakeField         : UITextField!
    @IBOutlet weak var vehicleModelField        : UITextField!
    @IBOutlet weak var vehicleRegistrationField : UITextField!
    
    var reponseSend                             : responseModelRegister!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passwordSwitcher(_ sender: Any)
    {
        if createPasswordField.isSecureTextEntry {
            createPasswordField.isSecureTextEntry = false
        } else {
            createPasswordField.isSecureTextEntry = true
        }
        if createPasswordField.isSecureTextEntry {
            createPasswordHidden.setImage(UIImage.init(named: "eye") , for: .normal)
        } else {
            createPasswordHidden.setImage(UIImage.init(named: "eye.slash") , for: .normal)
        }
    }

    @IBAction func passwordSwitcherTwo(_ sender: Any)
    {
        if varifyPasswordField.isSecureTextEntry {
            varifyPasswordField.isSecureTextEntry = false
        } else {
            varifyPasswordField.isSecureTextEntry = true
        }
        if varifyPasswordField.isSecureTextEntry {
            varifyPasswordHidden.setImage(UIImage.init(named: "eye") , for: .normal)
        } else {
            varifyPasswordHidden.setImage(UIImage.init(named: "eye.slash") , for: .normal)
        }
    }
    
    @IBAction func ButtonOnDate(_ sender: Any)
    {
        
    }
        
    @IBAction func nextButtonPressed(_ sender: Any)
    {
        if !(firstNameField.text?.isEmpty ?? false) || !(lastNameField.text?.isEmpty ?? false) || !(doBirthField.text?.isEmpty ?? false) || !(emailField.text?.isEmpty ?? false) || !(createPasswordField.text?.isEmpty ?? false) || !(varifyPasswordField.text?.isEmpty ?? false)
        {
            let carModel = carRegister(id: 0, make: self.vehicleMakeField.text ?? "", model: vehicleModelField.text ?? "", registrationNumber: vehicleRegistrationField.text ?? "")
            //yyyy-mm-dd
            reponseSend =  responseModelRegister(car: carModel, dob: doBirthField.text ?? "", driverNumber: "", driverToken: "", email: emailField.text ?? "", firstName: firstNameField.text ?? "", id: 0, lastName: lastNameField.text ?? "", password: createPasswordField.text ?? "")
            KRProgressHUD.show()
            ApiServices.CalAPIResponse(url: Endpoints.register, param: reponseSend.dict, method: .post)
            { responseVaue, successval, errorval, statusCode in
                if successval ?? false {
                    KRProgressHUD.dismiss()
                    print(responseVaue as Any)
                    if let responseHandler = Mapper<LoginResponseModel>().map(JSON: responseVaue?.dict ?? [:]) {
                        if responseHandler.code == 200 {
                            if responseHandler.error == nil{
                                
                                DispatchQueue.main.async {
                                    if let imagesViewController : LoginViewController = LoginViewController.instantiateViewControllerFromStoryboard() {
                                        self.navigationController?.pushViewController(imagesViewController, animated: true)
                                    }
                                }
                                
                               /* if let register = Mapper<updateUserData>().map(JSONObject: responseHandler.data)
                                {
                                    
                                    
//                                    let user = LoginData(
                                    
//                                    print("User Email \(register.driver?.email ?? "")")
                                    do {
                                        let dataa = try responseVaue?.rawData()
                                        UserDefaults.standard.set(dataa!, forKey: "loginUser")
                                    } catch (let error) {
                                        print(error.localizedDescription)
                                    }
                                    DataManager.shared.LoginResponse = responseHandler
                                    DispatchQueue.main.async {
                                        if let imagesViewController : ImagesViewController = ImagesViewController.instantiateViewControllerFromStoryboard() {
                                            self.navigationController?.pushViewController(imagesViewController, animated: true)
                                        }
                                    }
                                }*/
                            }
                        }else {
                            print(responseHandler.error ?? "")
                            DataManager.Alertbox(message: responseHandler.error ?? "", vc: self)
                        }
                    }
                } else {
                    print(errorval?.localizedDescription ?? "")
                    DataManager.Alertbox(message: errorval?.localizedDescription ?? "", vc: self)
                }
            }
        }
        else{
            print("please fill the fields")
            DataManager.Alertbox(message: "please fill the fields", vc: self)
        }
    }
}

extension Encodable {
    var dict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

