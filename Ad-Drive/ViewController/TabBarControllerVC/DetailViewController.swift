//
//  DetailViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 20/06/2022.
//

import UIKit
import ObjectMapper

class DetailViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var doBirthField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var createPasswordField: UITextField!
    @IBOutlet weak var varifyPasswordField: UITextField!
    
    @IBOutlet weak var createPasswordHidden: UIButton!
    @IBOutlet weak var varifyPasswordHidden: UIButton!
    
    @IBOutlet weak var vehicleMakeField: UITextField!
    @IBOutlet weak var vehicleModelField: UITextField!
    @IBOutlet weak var vehicleRegistrationField: UITextField!
    
    var reponseSend: responseModelRegister!
    
    var userData : LoginData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailField.isUserInteractionEnabled = false
        if let data = DataManager.shared.LoginResponse?.data {
            setupView(data: data)
        }
    }
    
    func setupView(data: LoginData)
    {
        userData = data
        let info = data.driver
        firstNameField.text             = info?.firstName ?? ""
        lastNameField.text              = info?.lastName ?? ""
        doBirthField.text               = info?.dob ?? ""
        emailField.text                 = info?.email ?? ""
        vehicleMakeField.text           = info?.car?.make ?? ""
        vehicleModelField.text          = info?.car?.model ?? ""
        vehicleRegistrationField.text   = info?.car?.registrationNumber ?? ""

    }
    
    
    @IBAction func passwordSwitcher(_ sender: Any) {
        if createPasswordField.isSecureTextEntry {
            createPasswordField.isSecureTextEntry = false
        } else {
            createPasswordField.isSecureTextEntry = true
        }
        if createPasswordField.isSecureTextEntry {
//            createPasswordHidden.setImage(UIImage(systemName: "eye") , for: .normal)
            createPasswordHidden.setImage(UIImage.init(named: "eye") , for: .normal)
        } else {
            createPasswordHidden.setImage(UIImage.init(named: "eye.slash") , for: .normal)
        }

    }
    
    @IBAction func passwordSwitcherTwo(_ sender: Any) {
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
    
    @IBAction func ButtonNotificationPressed(_ sender: Any)
    {
        if let imagesViewController : ImagesViewController = ImagesViewController.instantiateViewControllerFromStoryboard() {
            imagesViewController.fromHomeToImage = true
            self.navigationController?.pushViewController(imagesViewController, animated: true)
        }
    }
    
    
    @IBAction func EditButtonPressed(_ sender: Any)
    {
        if !(firstNameField.text?.isEmpty ?? false) || !(lastNameField.text?.isEmpty ?? false) || !(doBirthField.text?.isEmpty ?? false) || !(emailField.text?.isEmpty ?? false) || !(createPasswordField.text?.isEmpty ?? false) || !(varifyPasswordField.text?.isEmpty ?? false)
        {
            
            
            let carModel = carRegister(id: userData.driver?.car?.id ?? 0, make: self.vehicleMakeField.text ?? "", model: vehicleModelField.text ?? "", registrationNumber: vehicleRegistrationField.text ?? "")
            //yyyy-mm-dd
            reponseSend =  responseModelRegister(car: carModel, dob: doBirthField.text ?? "", driverNumber: userData.driver?.driverNumber ?? "", driverToken: userData.driver?.driverToken ?? "", email: emailField.text ?? "", firstName: firstNameField.text ?? "", id: userData.driver?.id ?? 0, lastName: lastNameField.text ?? "", password: createPasswordField.text ?? "")
            
            print("register request : -> ", reponseSend as Any)
            ApiServices.CalAPIResponse(url: Endpoints.register, param: reponseSend.dict, method: .post) { responseVaue, successval, errorval, statusCode in
                
                if successval ?? false {
                    print(responseVaue as Any)
                    if let responseHandler = Mapper<updateUserData>().map(JSON: responseVaue?.dict ?? [:]) {
                        if responseHandler.code == 200 {
                            if responseHandler.error == nil{
                                if let register = Mapper<LoginData>().map(JSONObject: responseHandler.data){
                                    print("User Email \(register.driver?.email ?? "")")

                                    do {
                                        let dataa = try responseVaue?.rawData()
                                        
                                        UserDefaults.standard.set(dataa!, forKey: "loginUser")
                                        
                                    } catch (let error) {
                                        print(error)
                                    }
//                                    DataManager.shared.LoginResponse = responseHandler
                                    
                                    print("Data updated successfully.....")

                                }
                            }
                        }else {
                            print(responseHandler.error ?? "")
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



struct updateUserData : Mappable {
    var code : Int?
    var error : String?
    var status : String?
    var data : DataUserUpdate?
    var message : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        code <- map["code"]
        error <- map["error"]
        status <- map["status"]
        data <- map["data"]
        message <- map["message"]
    }

}


struct DataUserUpdate : Mappable
{
    var email : String?
    var lastName : String?
    var driverToken : String?
    var driverNumber : String?
    var password : String?
    var dob : String?
    var id : Int?
    var compaign : String?
    var car : CarRegister?
    var firstName : String?

    init?(map: Map) {
    }

    mutating func mapping(map: Map) {

        email <- map["email"]
        lastName <- map["lastName"]
        driverToken <- map["driverToken"]
        driverNumber <- map["driverNumber"]
        password <- map["password"]
        dob <- map["dob"]
        id <- map["id"]
        compaign <- map["compaign"]
        car <- map["car"]
        firstName <- map["firstName"]
    }
}



struct CarRegister : Mappable {
    var id : Int?
    var imagesUrl : String?
    var make : String?
    var model : String?
    var registrationNumber : String?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        id <- map["id"]
        imagesUrl <- map["imagesUrl"]
        make <- map["make"]
        model <- map["model"]
        registrationNumber <- map["registrationNumber"]
    }

}


