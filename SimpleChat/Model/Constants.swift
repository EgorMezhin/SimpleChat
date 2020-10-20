//
//  Constants.swift
//  SimpleChat
//
//  Created by Egor Lass on 09.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

struct Constants {
    static let registerSegueIdentifier = "RegisterToChat"
    static let loginSegueIdentifier = "LoginToChat"
    static let appTitle = "SimpleChat"
    static let tableViewCellIdentifier = "ReusableCell"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
