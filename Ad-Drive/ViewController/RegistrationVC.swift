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
    
//    let mainObj = [
//        "cars" : car,
//        "bod" : "12-22",
//        "driverNumber": "string",
//        "driverToken": "string",
//        "email": "string",
//        "firstName": "string",
//        "id": 0,
//        "lastName": "string",
//        "password": "string"
//    ]
//
//    let car = [
//        "model" : "11",
//        "make" : "test"
//    ]
    
    
    let car = Car(id: 1, make: "", model: "test", registrationNumber: "1212")
    
    var reponseSend: responseModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reponseSend =  responseModel(car: car, dob: doBirthField.text ?? "" , driverNumber: "dasd", driverToken: "asdad", email: "qasim@gmail.com", firstName: "Muhammad", id: 1, lastName: "qasim", password: "12345")

        // Do any additional setup after loading the view.
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

            ApiServices.CalAPIResponse(url: Endpoints.register, param: reponseSend.dict, method: .post) { responseVaue, successval, errorval, statusCode in
                
                if successval ?? false {
                    _ = responseVaue
                    if let responseHandler = Mapper<ResponseHandler>().map(JSON: responseVaue?.dict ?? [:]) {
                        if responseHandler.code == 200 {
                            if responseHandler.error == nil{
                                if let register = Mapper<RegisterResponse>().map(JSONObject: responseHandler.data){
                                    print("User Email \(register.email)")
                                    
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

