//
//  DataManager.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 14/07/2022.
//

import Foundation
import CoreLocation


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
    
    
}
