//
//  ImagesViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 21/06/2022.
//

import UIKit

class ImagesViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    var imageView = 0
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var fourthImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // testing
        // Do any additional setup after loading the view.
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[.originalImage] as? UIImage {
            if imageView == 1{
                firstImage.image = image
            } else if imageView == 2{
                secondImage.image = image
            } else if imageView == 3{
                thirdImage.image = image
            } else if imageView == 4{
                fourthImage.image = image
            }
        }
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func nextButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            if let allowLocationServicesVC : AllowLocationServicesVC = AllowLocationServicesVC.instantiateViewControllerFromStoryboard() {
                self.navigationController?.pushViewController(allowLocationServicesVC, animated: true)
            }
        }
    }
    
    
    
}
