//
//  ViewController.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 01/06/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainView: CustomView!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.bringSubviewToFront(mainView)
        
        // Do any additional setup after loading the view.
    }


}

