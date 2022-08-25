//
//  AppDelegate.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 01/06/2022.
//

import UIKit
import CoreLocation
import ObjectMapper
import CoreMotion

var currentLat = 0.0
var currentLong = 0.0



@main
@available(iOS 13.0, *)
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let locationManager     = CLLocationManager()
    var timerSet                    = Timer()
    var activityManager       : CMMotionActivityManager?
    var callLocationFunction = true
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        checkusermotion()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate        = self
            locationManager.distanceFilter  = 5 //5 Meter Distance
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
//        self.timerSet = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.passLocation), userInfo: nil, repeats: true)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func passLocation()
    {
        if currentLat > 0.0
        {
            if let result = UserDefaults.standard.value(forKey: "loginUser") as? Data
            {
                do{
                    let jsonDecoder = JSONDecoder()
                    let dataobj = try jsonDecoder.decode(userDetailData.self, from: result)
                    
                    let id = dataobj.compaignId ?? 0 //dataobj.data?.driver?.compaign?.id ?? 0
                    let Driverid = dataobj.id ?? 0  //dataobj.data?.driver?.id ?? 0
                    let header = dataobj.token ?? ""
                    
                    let params = [
                        "compaignId"    : id,
                        "driverId"      : Driverid,
                        "lat"           : currentLat.rounded(toPlaces: 5),
                        "lon"           : currentLong.rounded(toPlaces: 5)
                    ] as [String : Any]
                    
                    print("\n\n\n Request is ---> \(params)")
                    
                    //let headers = ["Authorization":"key=\(header)","Accept":"application/json","Content-Type": "application/json"]
                    let headers = ["Authorization": "Bearer \(header)"]
                    
                    print("\n\n Header is --> \(headers)")
                    
                    // MARK: Request for response from the google
                    ApiServices.CalAPIResponsewithHeader(url: Endpoints.trackLocation, header: headers, param: params, method: .post)
                    { (response, success, error, statusCode) in
                        if success ?? false {
                            print("\n\n Response is --> \(response as Any)")
                        } else {
                            print(error?.localizedDescription ?? "")
                        }
                    }
                } catch {
                    print("erroMsg")
                }
            }
        }
    }
}

@available(iOS 13.0, *)
extension AppDelegate: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("### location updated")
        
        currentLat = manager.location?.coordinate.latitude ?? 0.0 //sourceLat //
        currentLong = manager.location?.coordinate.longitude ?? 0.0 //sourceLng //
        
        if callLocationFunction {
            passLocation()
        }
    }
}

///// FUNTIONS FOR MOTION CHECK
@available(iOS 13.0, *)
extension AppDelegate {
    
    func checkusermotion() {
        
        if CMMotionActivityManager.isActivityAvailable() {
            
            activityManager = CMMotionActivityManager()
            activityManager?.startActivityUpdates(
                to: OperationQueue(),
                withHandler: { activity in
                    
                    DispatchQueue.main.async(execute: {
//                        if activity?.stationary ?? false {
//                            print("###Stationary")
//                        } else if activity?.walking ?? false {
//                            print("###Walking")
//                        } else if activity?.running ?? false {
//                            print("###Running")
//                        } else if activity?.automotive ?? false {
//                            print("###Vehicle")
//                        } else if activity?.cycling ?? false {
//                            print("###Cycling")
//                        } else {
//                            print("###Unknown")
//                        }
                        if activity?.walking ?? false {
                            self.callLocationFunction = false
                            print("###Walking")
                        }else {
                            self.callLocationFunction = true
                            print("###Unknown")
                        }
                    })
                })
        }
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
