//
//  ApiService.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 29/06/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class ApiServices
{

//    static var headers = ["Authorization":"key=AAAAXmAuCFg:APA91bHyZycDmtvLe9VcdkKfFeZ7hrBdEbmkkECu9YLPGfL1iCfWm26jRDOvSbMb081p4MIqbQyuvOsJB4vjXlqdHIsyUi2V-iL-lhV1JHDo8Op7qxIlNTIz7vagZdgFUD16l4n3Inaz","Accept":"application/json","Content-Type": "application/json"]
    
    static var headers = [
        "Content-Type": "application/json",
    ]
    
    
   class func CalAPIResponse(url:String, param: [String:Any]?, method: HTTPMethod, completion: @escaping (JSON?, Bool?, Error?, Int?) -> Void) {
        
       Alamofire.request(url, method: method, parameters: param, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                let responseJSON = JSON(response.result.value as AnyObject?)
               
                return completion(responseJSON, true, nil,response.response?.statusCode)
            } else {
                return completion(nil, false, response.error, response.response?.statusCode)
            }
        }
    }
    
    
    class func SendNotification(url:String, params: [String:Any]?, method: HTTPMethod, completion: @escaping (JSON?, Bool?, Error?,Int?) -> Void) {
        
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                let responseJSON = JSON(response.result.value!)
                print(responseJSON)
                return completion(responseJSON, true, nil,response.response?.statusCode)
            } else {
                
//                print(response.error?.localizedDescription)
                return completion(nil, false, response.error, response.response?.statusCode)
            }
        }
    }
    
    class func multiPartAPIRequest(url: String, param: [String: Any]?, method: HTTPMethod, photos: [UIImage]?, imageName: String ,completion: @escaping (JSON?, Bool?, Error?, Int?) -> Void)
    {
        
        Alamofire.upload(multipartFormData: { (multipart) in
            for (key, value) in param ?? [:]
            {
                multipart.append("\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }
            for photo in photos ?? [] {
                multipart.append(photo.jpegData(compressionQuality: 0.5) ?? Data(), withName: "\(imageName)", fileName: "\(Date().timeIntervalSince1970)", mimeType: "image/jpeg")
            }
//            for photo in photos ?? [] {
//                multipart.append(photo.jpegData(compressionQuality: 0.5) ?? Data(), withName: "\(imageName)[]", fileName: "\(Date().timeIntervalSince1970)", mimeType: "image/jpeg")
//            }
        }, usingThreshold: UInt64.init(), to: url, method: method, headers: nil) { (result) in
            switch result
            {
            case .success(request: let request, streamingFromDisk: _, streamFileURL: _):
                request.responseJSON { (response) in
                    print(response)
                    if let responseT = response.result.value
                    {
                        let responseTemp = JSON(responseT)
                        return completion(responseTemp, true, nil, response.response?.statusCode)
                    }
                    else
                    {
                        return completion(nil, true, response.error, response.response?.statusCode)
                    }
                }
            case .failure(let error):
                print(error)
                return completion(nil, false, error, 0)
            }
        }
    }
}
