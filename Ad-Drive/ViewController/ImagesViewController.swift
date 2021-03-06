//
//  ImagesViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 21/06/2022.
//

import UIKit
import SDWebImage

class ImagesViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var imageView = 0
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    
    var fromHomeToImage = false
    
    var updatedImages = [false,false,false,false]
    
    var oldUrls = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImage.layer.cornerRadius = 10
        secondImage.layer.cornerRadius = 10
        thirdImage.layer.cornerRadius = 10
        fourthImage.layer.cornerRadius = 10
        
        
        if fromHomeToImage {
            
            if let data = DataManager.shared.LoginResponse?.data?.driver?.car?.imagesUrl
            {
                let img = #imageLiteral(resourceName: "placeholderImage")
                if data.count > 0
                {
                    for img in data {
                        oldUrls.append(img)
                    }
                    
                    firstImage.sd_setImage(with: URL(string: data[0]), placeholderImage: img)
                    secondImage.sd_setImage(with: URL(string: data[1]), placeholderImage: img)
                    thirdImage.sd_setImage(with: URL(string: data[2]), placeholderImage: img)
                    fourthImage.sd_setImage(with: URL(string: data[3]), placeholderImage: img)
                }
            }
            
        }
        
        
        
    }
    
    @IBAction func imageButtonPressed(_ sender: Any) {
        titleLabel.text = "hello."
        imageView = 1
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    
    @IBAction func secondButtonPressed(_ sender: Any) {
        imageView = 2
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    @IBAction func thirdButtonPressed(_ sender: Any) {
        imageView = 3
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
    }
    @IBAction func fourthButtonPressed(_ sender: Any) {
        imageView = 4
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true)
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
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any)
    {
        if fromHomeToImage {
            updateImages()
        } else {
            firstTimeAdd()
        }
    }
    
    func updateImages()
    {
        var imagesArray     = [UIImage]()
        var urlsArray       = [String]()
        
        if updatedImages[0] {
            imagesArray.append(firstImage.image!)
            urlsArray.append(oldUrls[0])
        }
        
        if updatedImages[1] {
            imagesArray.append(secondImage.image!)
            urlsArray.append(oldUrls[1])
        }
        
        if updatedImages[2] {
            imagesArray.append(thirdImage.image!)
            urlsArray.append(oldUrls[2])
        }
        
        if updatedImages[3] {
            imagesArray.append(fourthImage.image!)
            urlsArray.append(oldUrls[3])
        }
        
        let carid = DataManager.shared.LoginResponse?.data?.driver?.car?.id ?? 0
        
        let param = [
            "carId"         : "\(carid)",
            "oldImagesUrls" : urlsArray
        ] as! [String: AnyObject]
        
        print(param)
        
        let params = [
            "data" : param
        ]
        
        print(params)
        
//        let url = "http://ad-drive.co.nz/ad-drive/api/auth/edit/upload/car?data=werewew"
        let url = "http://ad-drive.co.nz/ad-drive/api/auth/edit/upload/car"
        
        
        
        ApiServices.multiPartAPIRequest(url: url, param: params as [String : Any], method: .post, photos: imagesArray, imageName: "files") { response, success, error, statusCode in
            
            if success ?? false {
                
                print(response as Any)
                
                
            }
        }

    }
    
    
    
    
    func firstTimeAdd() {
        
        
        if firstImage.image != UIImage.init(named: "placeholderImage") ||  secondImage.image != UIImage.init(named: "placeholderImage") || thirdImage.image  != UIImage.init(named: "placeholderImage") || fourthImage.image  != UIImage.init(named: "placeholderImage") {
            
            
            let carid = DataManager.shared.LoginResponse?.data?.driver?.car?.id ?? 0
            let url = "http://ad-drive.co.nz/ad-drive/api/auth/upload/car/\(carid)"
            
            var imagesArray = [UIImage]()
            
            imagesArray.append(firstImage.image!)
            imagesArray.append(secondImage.image!)
            imagesArray.append(thirdImage.image!)
            imagesArray.append(fourthImage.image!)
            
            
            ApiServices.multiPartAPIRequest(url: url, param: nil, method: .post, photos: imagesArray, imageName: "files") { response, success, error, statusCode in
                
                if success ?? false {
                    print(response as Any)
                    
                    let imagesResponse = response?["data"].arrayValue
                    
                    var imagesArray = [String]()
                    for response in imagesResponse ?? [] {
                        print(response.stringValue)
                        imagesArray.append(response.stringValue)
                    }
                    DataManager.shared.LoginResponse?.data?.driver?.car?.imagesUrl = imagesArray

                    if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AllowLocationServicesVC") as? AllowLocationServicesVC {
                        
                        self.navigationController?.pushViewController(controller, animated: true)
                    }
                }
            }
        } else {
            print("please select all four images")
        }
        
    }
    
    
    
    
}
