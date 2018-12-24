//
//  AppConfig.swift
//  SwiftyRxMVVM
//
//  Created by Yunus Alkan on 19.12.2018.
//  Copyright © 2018 Yunus Alkan. All rights reserved.
//

import Foundation

/**
 * Another way is to define pre defined macros in project settings
 * For examples: STAGING, UAT etc.
 * Reading from infoDictionary is automatically bind "API_BASE_URL" string variable to ${API_BASE_URL} according to macros.
 * However; I like to use another approach.
 -----
 
 final class AppConfig {
 static var baseURL: URL!
 
 static func configure() {
 guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"), let apiConfig = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any> else {
 fatalError("No defined Api plist file!")
 }
 
 baseURL = URL(string: infoDict["API_BASE_URL"] as! String)
 }
 }
 */

final class AppConfig {
    
    static var baseURL: URL!
    static var isDebug: Bool = false
    static var isDevelop: Bool = false
    static var isStaging: Bool = false
    static var isRelease: Bool = false
    
    static func configure() {
        #if DEBUG
            isDebug = true
        #endif

        #if DEVELOP
            isDevelop = true
        #elseif STAGING
            isStaging = true
        #elseif RELEASE
            isRelease = true
        #endif
        
        loadFromConfigFile()
    }
    
    private static func loadFromConfigFile() {
        var fileName: String = "Config-Develop"
        
        if isStaging {
            fileName = "Config-Staging"
        }
        else if isRelease {
            fileName = "Config-Release"
        }
        else if isDevelop {
            fileName = "Config-Develop"
        }
        
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"), let config = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            fatalError("No defined Config plist file!")
        }
        
        baseURL = URL(string: config["BaseUrl"] as! String)
        debugPrint("Application has been loaded with \(fileName).plist successfully.")
    }
}

extension AppConfig {
    static var baseHeaders: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
