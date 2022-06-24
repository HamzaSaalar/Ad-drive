//
//  GalleryViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 22/06/2022.
//

import UIKit

class GalleryViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let colorArray = [UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow,UIColor.orange, UIColor.purple, UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow,UIColor.orange, UIColor.purple,UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow,UIColor.orange, UIColor.purple,UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow,UIColor.orange, UIColor.purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagesCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "imagesArray")

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
    }
    
}
    
    extension GalleryViewController: UICollectionViewDelegate , UICollectionViewDataSource{
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return colorArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesArray", for: indexPath) as! ImagesCollectionViewCell
            cell.imageView.backgroundColor = colorArray[indexPath.row]
           
           return cell
        }

    }

     extension GalleryViewController: UICollectionViewDelegateFlowLayout{
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let yourWidth = collectionView.bounds.width/3.0
           let yourHeight = yourWidth
           return CGSize(width: yourWidth - 5, height: yourHeight - 5)
       }


       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 5
       }

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 5
       }
    }


