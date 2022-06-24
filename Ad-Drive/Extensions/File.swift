//
//  File.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 01/06/2022.
//

import Foundation
import UIKit

extension UIViewController{
    
    //MARK: -  Properties
    var myStoryBoard: UIStoryboard {
        
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    /***
     Initialize a UIViewController from Storyboard.
     
     
     - returns: UIViewController.
     */
    class func instantiateViewControllerFromStoryboard<T>() -> T? where T : UIViewController {
        return instantiateViewController()
    }
    
    /***
     Initialize a UIViewController from Storyboard.
     
     
     - returns: UIViewController.
     */
    fileprivate class func instantiateViewController<T>() -> T? where T : UIViewController  {
        return UIViewController().myStoryBoard.instantiateViewController(withIdentifier: String(describing: self)) as? T
    }

    
}
