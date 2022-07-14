//
//  SceneDelegate.swift
//  Ad-Drive
//
//  Created by Hamza Sallar on 01/06/2022.
//

import UIKit
import IQKeyboardManagerSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        IQKeyboardManager.shared.enable = true
        if #available(iOS 13.0, *) {
            guard let _ = (scene as? UIWindowScene) else { return }
        } else {
            // Fallback on earlier versions
        }
    }

}

