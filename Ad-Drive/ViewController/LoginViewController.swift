//
//  LoginViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 18/06/2022.
//

import UIKit
import ObjectMapper
import KRProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var showHideButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        userNameField.text = "qasim6@gmail.com"
//        passwordField.text = "123123123"
    }

    
    @IBAction func registerButtonPressed(_ sender: Any)
    {
        DispatchQueue.main.async {
            if let registrationVC : RegistrationVC = RegistrationVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(registrationVC, animated: true)
            }
        }
    }
    
    @IBAction func actionSignin(_ sender: Any)
    {
        if userNameField.text != "" || passwordField.text != "" {
            let params = [
                "email"         : self.userNameField.text ?? "",
                "password"      : self.passwordField.text ?? "",
                "type"          : "d"
            ]
            KRProgressHUD.show()
//            KRProgressHUD.showMessage("Please wait ...")
            ApiServices.CalAPIResponse(url: Endpoints.login, param: params, method: .post)
            { responseVaue, successval, errorval, statusCode in
                KRProgressHUD.dismiss()
                if successval ?? false {
                    
                    print(responseVaue as Any)
                    if let dataobj = Mapper<LoginResponseModel>().map(JSONObject: responseVaue?.rawValue)
                    {
                        if dataobj.data != nil {
                            
                            let uData = userDetailData(token: dataobj.data?.token ?? "",
                                                       driverToken: dataobj.data?.driver?.driverToken ?? "",
                                                       driverNumber: dataobj.data?.driver?.driverNumber ?? "",
                                                       email: dataobj.data?.driver?.email ?? "",
                                                       password: self.passwordField.text ?? "",
                                                       lastName: dataobj.data?.driver?.lastName ?? "",
                                                       id: dataobj.data?.driver?.id ?? 0,
                                                       firstName: dataobj.data?.driver?.firstName ?? "",
                                                       dob: dataobj.data?.driver?.dob ?? "",
                                                       compaignName: dataobj.data?.driver?.compaign?.compaignName ?? "",
                                                       compaignDescription: dataobj.data?.driver?.compaign?.description ?? "",
                                                       compaignEndDate: dataobj.data?.driver?.compaign?.endDate ?? "",
                                                       compaignId: dataobj.data?.driver?.compaign?.id ?? 0,
                                                       compaignStartDate: dataobj.data?.driver?.compaign?.startDate ?? "",
                                                       compaignStatus: dataobj.data?.driver?.compaign?.status ?? "",
                                                       carId: dataobj.data?.driver?.car?.id ?? 0,
                                                       carImagesUrl: dataobj.data?.driver?.car?.imagesUrl ?? [],
                                                       carMake: dataobj.data?.driver?.car?.make ?? "",
                                                       carModel: dataobj.data?.driver?.car?.model ?? "",
                                                       carRegistrationNumber: dataobj.data?.driver?.car?.registrationNumber ?? ""
                            )
                            
                            print(uData)
                            print("")
                            
                            do {
                                
                                let encodedData = try JSONEncoder().encode(uData)
                                let jsonString = String(data: encodedData, encoding: .utf8)
                                let jsonData = Data(jsonString!.utf8)
                                //let dataa = try responseVaue?.rawData()
                                UserDefaults.standard.set(jsonData, forKey: "loginUser")
                            } catch (let error) {
                                print(error)
                            }
//                            DataManager.shared.LoginResponse = dataobj
                            DataManager.shared.userData = uData
                            if dataobj.data?.driver?.car?.imagesUrl?.count ?? 0 > 0
                            { // contain Images Directly navigate to Home
                                DispatchQueue.main.async {
                                    if let tabBarVC : TabBarVC = TabBarVC.instantiateViewControllerFromStoryboard() {
                                        self.navigationController?.pushViewController(tabBarVC, animated: true)
                                    }
                                }
                            } else { // send to images controller
                                DispatchQueue.main.async {
                                    if let imagesViewController : ImagesViewController = ImagesViewController.instantiateViewControllerFromStoryboard() {
                                        self.navigationController?.pushViewController(imagesViewController, animated: true)
                                    }
                                }
                            }
                        } else {
                            DataManager.Alertbox(message: dataobj.message ?? "", vc: self)
                        }
                    }
                } else {
                    print(errorval?.localizedDescription ?? "")
                    DataManager.Alertbox(message: errorval?.localizedDescription ?? "", vc: self)
                }
            }
        } else {
            print("Please fill both the fields")
        }
    }
    
    @IBAction func showPasswordPressed(_ sender: Any)
    {
        if passwordField.isSecureTextEntry {
            passwordField.isSecureTextEntry = false
        } else {
            passwordField.isSecureTextEntry = true
        }
        if passwordField.isSecureTextEntry {
//            showHideButton.setImage(UIImage(systemName: "eye.slash") , for: .normal)
            showHideButton.setImage(UIImage.init(named: "Hide"), for: .normal)
        } else {
            showHideButton.setImage(UIImage.init(named: "eye"), for: .normal)
        }
    }
}

extension LoginViewController : UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == userNameField{
            if range.location == 0 && string == " "{
                return false
            }
            if textField.text!.contains(" ") && string == " " {
                return false
            }
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
