//
//  responseHandler.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 30/06/2022.
//

import Foundation



import UIKit
import ObjectMapper

class ResponseHandler: Mappable {

    // MARK: - Properties

    var data: Any?
    var error: String?
    var message: String?
    var code: Int?
    var status: String? // data can be nil

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        data          <-  map["data"]
        error          <- map["error"]
        message          <- map["message"]
        code           <- map["code"]
        status         <- map["status"]
    }
    // MARK: Transforms

    let transform = TransformOf<Bool, String>(fromJSON: { (value: String?) -> Bool? in

        if value == "true" {
            return true
        }

        return false

    }, toJSON: { (value: Bool?) -> String? in

        if let value = value {

            if value == true {
                return "true"
            }
            
            return "false"
        }
        
        return "false"
    })
    
}
