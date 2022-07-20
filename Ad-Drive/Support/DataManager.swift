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
    var LoginResponse               : LoginResponseModel? = nil
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
    
    
}
