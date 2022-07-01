//
//  RegistrationVC.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 23/06/2022.
//

import UIKit
import ObjectMapper

class RegistrationVC: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var doBirthField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var createPasswordField: UITextField!
    
    @IBOutlet weak var createPasswordHidden: UIButton!
    @IBOutlet weak var varifyPasswordHidden: UIButton!
    
    @IBOutlet weak var varifyPasswordField: UITextField!
    @IBOutlet weak var vehicleMakeField: UITextField!
    @IBOutlet weak var vehicleModelField: UITextField!
    @IBOutlet weak var vehicleRegistrationField: UITextField!
    
    
    var reponseSend: responseModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func passwordSwitcher(_ sender: Any) {
        if createPasswordField.isSecureTextEntry {
            createPasswordField.isSecureTextEntry = false
        } else {
            createPasswordField.isSecureTextEntry = true
        }
        if createPasswordField.isSecureTextEntry {
            createPasswordHidden.setImage(UIImage(systemName: "eye") , for: .normal)
        } else {
            createPasswordHidden.setImage(UIImage(systemName: "eye.slash") , for: .normal)
        }

    }
    @IBAction func passwordSwitcherTwo(_ sender: Any) {
        if varifyPasswordField.isSecureTextEntry {
            varifyPasswordField.isSecureTextEntry = false
        } else {
            varifyPasswordField.isSecureTextEntry = true
        }
        if varifyPasswordField.isSecureTextEntry {
            varifyPasswordHidden.setImage(UIImage(systemName: "eye") , for: .normal)
        } else {
            varifyPasswordHidden.setImage(UIImage(systemName: "eye.slash") , for: .normal)
        }
        
    }
    struct Car : Codable {
        let id : Int?
//        let imagesUrl : [String]?
        let make : String?
        let model : String?
        let registrationNumber : String?
    }
    
    struct responseModel : Codable {
        let car : Car?
        let dob : String?
        let driverNumber : String?
        let driverToken : String?
        let email : String?
        let firstName : String?
        let id : Int?
        let lastName : String?
        let password : String?
        
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if !(firstNameField.text?.isEmpty ?? false) || !(lastNameField.text?.isEmpty ?? false) || !(doBirthField.text?.isEmpty ?? false) || !(emailField.text?.isEmpty ?? false) || !(createPasswordField.text?.isEmpty ?? false) || !(varifyPasswordField.text?.isEmpty ?? false) {
            
            
            
            let carModel = Car(id: 0, make: self.vehicleMakeField.text ?? "", model: vehicleModelField.text ?? "", registrationNumber: "123444")
            //yyyy-mm-dd
            reponseSend =  responseModel(car: carModel, dob: doBirthField.text ?? "", driverNumber: "", driverToken: "", email: "hamza2@gmail.com", firstName: "Muhammad ", id: 0, lastName: "Hamza", password: "123456")
            
            
            ApiServices.CalAPIResponse(url: Endpoints.register, param: reponseSend.dict, method: .post) { responseVaue, successval, errorval, statusCode in
                
                if successval ?? false {
                     print(responseVaue)
                    if let responseHandler = Mapper<ResponseHandler>().map(JSON: responseVaue?.dict ?? [:]) {
                        if responseHandler.code == 200 {
                            if responseHandler.error == nil{
                                if let register = Mapper<RegisterResponse>().map(JSONObject: responseHandler.data){
                                    print("User Email \(register.email)")
                                    
                                    UserDefaults.standard.set(register, forKey: "UserData")
                                    
                                    
//                                    let value = UserDefaults.standard.value(forKey: "UserData") as? RegisterResponse
//
//                                    value?.email
                                    
                                    
                                    DispatchQueue.main.async {
                                        if let imagesViewController : ImagesViewController = ImagesViewController.instantiateViewControllerFromStoryboard() {
                                            self.navigationController?.pushViewController(imagesViewController, animated: true)
                                        }
                                    }
                                    
                                }
                            }
                        }else {
                            print(responseHandler.error)
                        }
                    }
                } else {
                    print(errorval?.localizedDescription ?? "")
                }
                
            }
           
        }
        else{
            print("please fill the fields")
        }
    }
}





extension Encodable {
    var dict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

