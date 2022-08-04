//
//  DataManager.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 14/07/2022.
//

import UIKit
import Foundation
import CoreLocation
import CoreMotion
import UserNotifications


class DataManager : NSObject {
    
    static let shared               = DataManager()
//    var LoginResponse               : userDetailData ? = nil //: LoginResponseModel? = nil
    var userData                    : userDetailData?
    private let locationManager     = CLLocationManager()
    
    
    func locationPermission() -> Bool {
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                return true
            @unknown default:
                return false
                break
            }
        } else {
            print("Location services are not enabled")
        }
        
        return false
    }
    
//    func motionPermission() -> Bool {
//        
//        if cmmot
//    }
    
    
    func checkNotificationsEnabled() -> Bool
    {
        var check = false
        if #available(iOS 10.0, *) {
            let current = UNUserNotificationCenter.current()
            current.getNotificationSettings(completionHandler: { settings in
                
                if settings.authorizationStatus == .authorized {
                    check = true
                } else {
                    check = false
                }
            })
        } else {
            // Fallback on earlier versions
            if UIApplication.shared.isRegisteredForRemoteNotifications {
                check = true
                print("APNS-YES")
            } else {
                check = false
                print("APNS-NO")
            }
        }
        return check ? true : false
    }
    
    func checkMotionPermission() -> Bool {
        
        if CMMotionActivityManager.authorizationStatus() == .authorized {
            return true
        } else {
            return false
        }
    }
    
    static func AlertboxWithBackOption(message: String, vc: UIViewController, completion: @escaping () -> (Void)) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            vc.dismiss(animated: false, completion: nil)
            completion()
        }))
        vc.present(alert, animated: false, completion: nil)
    }
    
    static func Alertbox(message: String, vc: UIViewController){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)

        alert.addAction(OKAction)
        vc.present(alert, animated: true, completion: nil)
    }

}
