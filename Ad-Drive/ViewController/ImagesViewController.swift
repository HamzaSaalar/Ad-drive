//
//  ImagesViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 21/06/2022.
//

import UIKit
import SDWebImage
import KRProgressHUD

class ImagesViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var titleLabel   : UILabel!
    @IBOutlet weak var firstImage   : UIImageView!
    @IBOutlet weak var secondImage  : UIImageView!
    @IBOutlet weak var thirdImage   : UIImageView!
    @IBOutlet weak var fourthImage  : UIImageView!
    @IBOutlet weak var buttonBack   : UIButton!
    @IBOutlet weak var buttonUpdate : UIButton!
    
    var imageView       = 0
    var fromHomeToImage = false
    var updatedImages   = [false,false,false,false]
    var oldUrls         = [String]()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        firstImage.layer.cornerRadius   = 10
        secondImage.layer.cornerRadius  = 10
        thirdImage.layer.cornerRadius   = 10
        fourthImage.layer.cornerRadius  = 10
        
        if fromHomeToImage {
            buttonUpdate.titleLabel?.text = "Update Images"
            if let data = DataManager.shared.userData?.carImagesUrl {
                if data.count > 0 {
                    setimages(data: data)
                }
            }
        } else {
            buttonUpdate.titleLabel?.text = "Next"
            buttonBack.isHidden = true
        }
    }

    func setimages(data:[String]) {
        let img = #imageLiteral(resourceName: "placeholderImage")
        
        firstImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        firstImage.sd_setImage(with: URL(string: data[0]), placeholderImage: img)
        
        secondImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        secondImage.sd_setImage(with: URL(string: data[1]), placeholderImage: img)
        
        thirdImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        thirdImage.sd_setImage(with: URL(string: data[2]), placeholderImage: img)
        
        fourthImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        fourthImage.sd_setImage(with: URL(string: data[3]), placeholderImage: img)
    }
    
    @IBAction func imageButtonPressed(_ sender: Any)
    {
        imageView = 1
        photopickerAlert()
    }
    
    @IBAction func secondButtonPressed(_ sender: Any)
    {
        imageView = 2
        photopickerAlert()
    }
    
    @IBAction func thirdButtonPressed(_ sender: Any)
    {
        imageView = 3
        photopickerAlert()
    }
    
    @IBAction func fourthButtonPressed(_ sender: Any)
    {
        imageView = 4
        photopickerAlert()
    }
    
    func photopickerAlert()
    {
        let controller = UIAlertController(title: "Select photo from", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            self.present(imagePickerVC, animated: true)
        }
        
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { action in
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .photoLibrary
            imagePickerVC.delegate = self
            self.present(imagePickerVC, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        controller.addAction(cameraAction)
        controller.addAction(galleryAction)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.originalImage] as? UIImage
        {
            if imageView == 1 {
                updatedImages[0] = true
                firstImage.image = image
            } else if imageView == 2 {
                updatedImages[1] = true
                secondImage.image = image
            } else if imageView == 3 {
                updatedImages[2] = true
                thirdImage.image = image
            } else if imageView == 4 {
                updatedImages[3] = true
                fourthImage.image = image
            }
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any)
    {
        KRProgressHUD.show()
        
        if fromHomeToImage {
            updateImages()
        } else {
            firstTimeAdd()
        }
    }
    
    func updateImages()
    {
        var imagesArray     = [imageForMultipart]()
        let carid           = DataManager.shared.userData?.carId ?? 0
        
        if updatedImages[0] {
            let img1 = imageForMultipart(image: firstImage.image!, name: "IMG_1_Car_\(carid)")
            imagesArray.append(img1)
        }
        if updatedImages[1] {
            let img1 = imageForMultipart(image: secondImage.image!, name: "IMG_2_Car_\(carid)")
            imagesArray.append(img1)
        }
        if updatedImages[2] {
            let img1 = imageForMultipart(image: thirdImage.image!, name: "IMG_2_Car_\(carid)")
            imagesArray.append(img1)
        }
        if updatedImages[3] {
            let img1 = imageForMultipart(image: fourthImage.image!, name: "IMG_4_Car_\(carid)")
            imagesArray.append(img1)
        }
        
        let url = "http://ad-drive.co.nz/ad-drive/api/auth/upload/car/\(carid)"
        
        ApiServices.multiPartAPIRequest(url: url, param: nil, method: .post, photos: imagesArray, imageName: "files") { response, success, error, statusCode in
            KRProgressHUD.dismiss()
            if success ?? false
            {
                print(response as Any)
                let imagesResponse = response?["data"].arrayValue
                var imagesArray = [String]()
                
                if imagesResponse?.count ?? 0 > 0 {
                    
                    for response in imagesResponse ?? [] {
                        imagesArray.append(response.stringValue)
                    }
                    
                    do {
                        
                        var uData    = DataManager.shared.userData
                        uData?.carImagesUrl = imagesArray
                        
                        let encodedData = try JSONEncoder().encode(uData)
                        let jsonString = String(data: encodedData, encoding: .utf8)
                        let jsonData = Data(jsonString!.utf8)
                        //let dataa = try responseVaue?.rawData()
                        UserDefaults.standard.set(jsonData, forKey: "loginUser")
                        DataManager.shared.userData = uData
                        KRProgressHUD.showMessage("Images added successfully!")
                    } catch (let error) {
                        print(error)
                    }
                } else {
                    DataManager.Alertbox(message: response?["message"].stringValue ?? "please try again", vc: self)
                }
            }
        }
    }
    
    func firstTimeAdd()
    {
        if firstImage.image != UIImage.init(named: "placeholderImage") ||  secondImage.image != UIImage.init(named: "placeholderImage") || thirdImage.image  != UIImage.init(named: "placeholderImage") || fourthImage.image  != UIImage.init(named: "placeholderImage")
        {
            
            let carid = DataManager.shared.userData?.carId ?? 0
            let url = "http://ad-drive.co.nz/ad-drive/api/auth/upload/car/\(carid)"
            
            var imagesArray = [imageForMultipart]()
            
            let img1 = imageForMultipart(image: firstImage.image!, name: "IMG_1_Car_\(carid)")
            imagesArray.append(img1)
            let img2 = imageForMultipart(image: secondImage.image!, name: "IMG_2_Car_\(carid)")
            imagesArray.append(img2)
            let img3 = imageForMultipart(image: thirdImage.image!, name: "IMG_3_Car_\(carid)")
            imagesArray.append(img3)
            let img4 = imageForMultipart(image: fourthImage.image!, name: "IMG_4_Car_\(carid)")
            imagesArray.append(img4)
            
            
            ApiServices.multiPartAPIRequest(url: url, param: nil, method: .post, photos: imagesArray, imageName: "files")
            { response, success, error, statusCode in
                KRProgressHUD.dismiss()
                if success ?? false
                {
                    print(response as Any)
                    let imagesResponse = response?["data"].arrayValue
                    var imagesArray = [String]()
                    
                    if imagesResponse?.count ?? 0 > 0 {
                        
                        for response in imagesResponse ?? []
                        {
                            print(response.stringValue)
                            imagesArray.append(response.stringValue)
                        }
                        
                        
                        do {
                            
                            var uData    = DataManager.shared.userData
                            uData?.carImagesUrl = imagesArray
                            
                            let encodedData = try JSONEncoder().encode(uData)
                            let jsonString = String(data: encodedData, encoding: .utf8)
                            let jsonData = Data(jsonString!.utf8)
                            //let dataa = try responseVaue?.rawData()
                            UserDefaults.standard.set(jsonData, forKey: "loginUser")
                            DataManager.shared.userData = uData
                            
                            KRProgressHUD.showMessage("Images added successfully!")
                            
                        } catch (let error) {
                            print(error)
                        }
                        
                        //if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllowLocationServicesVC") as? AllowLocationServicesVC {
                        //self.navigationController?.pushViewController(controller, animated: true)
                        //}
                        
                        DispatchQueue.main.async {
                            if let tabBarVC : TabBarVC = TabBarVC.instantiateViewControllerFromStoryboard() {
                                self.navigationController?.pushViewController(tabBarVC, animated: true)
                            }
                        }
                    } else {
                        DataManager.Alertbox(message: response?["message"].stringValue ?? "please try again", vc: self)
                    }
                } else {
                    DataManager.Alertbox(message: error?.localizedDescription ?? "please try again", vc: self)
                }
            }
        } else {
            print("please select all four images")
        }
    }
}
