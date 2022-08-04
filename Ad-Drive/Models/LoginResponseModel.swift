//
//  LoginResponseModel.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 13/07/2022.
//

import Foundation
import ObjectMapper

struct LoginResponseModel : Mappable {
    
    var data : LoginData?
    var error : String?
    var status : String?
    var message : String?
    var code : Int?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        data <- map["data"]
        error <- map["error"]
        status <- map["status"]
        message <- map["message"]
        code <- map["code"]
    }

}


struct LoginData : Mappable {
    var token : String?
    var driver : LoginDriver?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        token <- map["token"]
        driver <- map["driver"]
    }

}


struct LoginDriver : Mappable {
    var driverToken : String?
    var driverNumber : String?
    var email : String?
    var password : String?
    var lastName : String?
    var compaign : Compaign?
    var id : Int?
    var firstName : String?
    var dob : String?
    var car : Car?

    init?(map: Map) {

    }

    mutating func mapping(map: Map) {

        driverToken <- map["driverToken"]
        driverNumber <- map["driverNumber"]
        email <- map["email"]
        password <- map["password"]
        lastName <- map["lastName"]
        compaign <- map["compaign"]
        id <- map["id"]
        firstName <- map["firstName"]
        dob <- map["dob"]
        car <- map["car"]
    }

}


struct userDetailData: Codable {
    
    var token : String?
    var driverToken : String?
    var driverNumber : String?
    var email : String?
    var password : String?
    var lastName : String?
//    var compaign : Compaign?
    var id : Int?
    var firstName : String?
    var dob : String?
//    var car : Car?
    
    var compaignName : String?
    var compaignDescription : String?
    var compaignEndDate : String?
    var compaignId : Int?
    var compaignStartDate : String?
    var compaignStatus : String?
    
    var carId : Int?
    var carImagesUrl : [String]?
    var carMake : String?
    var carModel : String?
    var carRegistrationNumber : String?
}
