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
    
//    func isValidPhone(phoneStr:String?) -> Bool {
//        guard phoneStr != nil else { return false }
//
//        let testPhone = NSPredicate(format:"SELF MATCHES %@","\\d{3}-\\d{3}-\\d{4}$" )
//        return testPhone.evaluate(with: phoneStr)
//    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters atleast
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,10}")
        return passwordTest.evaluate(with: testStr)
        
    }
    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }

    
}
