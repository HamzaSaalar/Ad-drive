//
//  DetailViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 20/06/2022.
//

import UIKit
import ObjectMapper
import KRProgressHUD

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
    var startTimePicker         = UIDatePicker()
    
    var userData : userDetailData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailField.isUserInteractionEnabled = false
        if let data = DataManager.shared.userData {
            setupView(data: data)
        }
    }
    
    func setupView(data: userDetailData)
    {
        userData = data
        let info = data
        firstNameField.text             = info.firstName ?? ""
        lastNameField.text              = info.lastName ?? ""
        doBirthField.text               = info.dob ?? ""
        emailField.text                 = info.email ?? ""
        vehicleMakeField.text           = info.carMake ?? ""
        vehicleModelField.text          = info.carModel ?? ""
        vehicleRegistrationField.text   = info.carRegistrationNumber ?? ""
        createPasswordField.text        = info.password ?? ""
        varifyPasswordField.text        = info.password ?? ""

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
    
    @IBAction func DOBTapped(_ sender: Any)
    {
        setupSTimePicker(self.doBirthField)
    }
    
    
    @IBAction func ButtonOnDate(_ sender: Any) // we are not using this
    {
        setupSTimePicker(doBirthField)
    }
    
    
    func setupSTimePicker(_ textField : UITextField) {
        
        // DatePicker
        self.startTimePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.startTimePicker.backgroundColor = UIColor.white
        
//        startTimePicker.locale = Locale(identifier: "en_GB")
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-mm-dd" //"HH:mm"
        
        /// AS THIS IS START SO SET MAX TIME
//        if #available(iOS 15, *) {
//            startTimePicker.maximumDate = .now
//        } else {
//            // Fallback on earlier versions
//        }
        
        startTimePicker.maximumDate = Date()
        
        self.startTimePicker.datePickerMode = UIDatePicker.Mode.date
        textField.inputView = self.startTimePicker
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        if #available(iOS 13.4, *) {
            startTimePicker.preferredDatePickerStyle = .wheels
            toolBar.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        }
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneClickStart(_:)))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClickStart))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClickStart(_ sender: UIDatePicker) {
        displayingDate()
    }
    func displayingDate () {
        
        let dateFormatter1 = DateFormatter()
        //dateFormatter1.dateStyle = .medium
        dateFormatter1.dateFormat = "yyyy-mm-dd"
        //dateFormatter1.timeStyle = .none
//        startTimePicker.maximumDate = Date()
        
        doBirthField.text = dateFormatter1.string(from: startTimePicker.date)
        doBirthField.resignFirstResponder()
        
    }
    
    @objc func cancelClickStart() {
        doBirthField.resignFirstResponder()
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
            KRProgressHUD.show()
            let carModel = carRegister(id: userData.carId ?? 0, make: self.vehicleMakeField.text ?? "", model: vehicleModelField.text ?? "", registrationNumber: vehicleRegistrationField.text ?? "")
            //yyyy-mm-dd
            reponseSend =  responseModelRegister(car: carModel, dob: doBirthField.text ?? "", driverNumber: userData.driverNumber ?? "", driverToken: userData.driverToken ?? "", email: emailField.text ?? "", firstName: firstNameField.text ?? "", id: userData.id ?? 0, lastName: lastNameField.text ?? "", password: createPasswordField.text ?? "")
            
            print("register request : -> ", reponseSend as Any)
            ApiServices.CalAPIResponse(url: Endpoints.register, param: reponseSend.dict, method: .post) { responseVaue, successval, errorval, statusCode in
                KRProgressHUD.dismiss()
                if successval ?? false {
                    print(responseVaue as Any)
                    if let responseHandler = Mapper<updateUserData>().map(JSON: responseVaue?.dict ?? [:]) {
                        if responseHandler.code == 200 {
                            if responseHandler.error == nil {
                                if let _ = Mapper<updateUserData>().map(JSONObject: responseHandler.data) {

                                    let uData = userDetailData(token: self.userData.token,
                                                               driverToken: self.userData.driverToken,
                                                               driverNumber: self.userData.driverNumber,
                                                               email: self.emailField.text ?? self.userData.email,
                                                               password: self.createPasswordField.text ?? "",
                                                               lastName: self.lastNameField.text ?? "",
                                                               id: self.userData.id,
                                                               firstName: self.firstNameField.text ?? "",
                                                               dob: self.doBirthField.text ?? "",
                                                               compaignName: self.userData.compaignName,
                                                               compaignDescription: self.userData.compaignDescription,
                                                               compaignEndDate: self.userData.compaignEndDate,
                                                               compaignId: self.userData.compaignId,
                                                               compaignStartDate: self.userData.compaignStartDate,
                                                               compaignStatus: self.userData.compaignStatus,
                                                               carId: self.userData.carId,
                                                               carImagesUrl: self.userData.carImagesUrl,
                                                               carMake: self.vehicleMakeField.text ?? "",
                                                               carModel: self.vehicleModelField.text ?? "",
                                                               carRegistrationNumber: self.vehicleRegistrationField.text ?? ""
                                    )
                                    
                                    do {
                                        
                                        let encodedData = try JSONEncoder().encode(uData)
                                        let jsonString = String(data: encodedData, encoding: .utf8)
                                        let jsonData = Data(jsonString!.utf8)
                                        //let dataa = try responseVaue?.rawData()
                                        UserDefaults.standard.set(jsonData, forKey: "loginUser")
                                    } catch (let error) {
                                        print(error)
                                    }
                                    DataManager.shared.userData = uData
                                    KRProgressHUD.showSuccess(withMessage: "Data updated successfully")
                                    
                                    print("Data updated successfully.....")
                                }
                            }
                        }else {
                           // print(responseHandler.error ?? "")
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


