//
//  Endpoints.swift
//  Ad-Drive
//
//  Created by Muhammad Qasim on 29/06/2022.
//

import Foundation

class Endpoints {
    
    static let baseURL = "http://ad-drive.co.nz/ad-drive/api"
    
    static let login            = "\(baseURL)/auth/driver/login"
    //static let imageURL       = "http://"
    static let register         = "\(baseURL)/auth/register/drive"
    static let trackLocation    = "\(baseURL)/compaigns/tracking/save"
}
