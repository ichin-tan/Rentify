//
//  Global.swift
//  Rentify
//
//  Created by CP on 10/03/25.
//

import Foundation

enum Role: String {
    case Guest = "GUEST"
    case Landlord = "LANDLORD"
    case Tenant = "TENANT"
}

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

let USER_COLLECTION = "Users"
let PROPERTY_COLLECTION = "Properties"

let UD = UserDefaults.standard
//var UD_KEY_CURRENT_USER = "CURRENT_USER"
var UD_KEY_REMEMBER_ME = "REMEMBER_ME"
var UD_CURRENT_USER_EMAIL = "CURRENT_USER_EMAIL"
var UD_CURRENT_USER_PASSWORD = "CURRENT_USER_PASSWORD"

//func getCurrentUserFromUD() -> User? {
//    if let udCurrentUserData = UD.data(forKey: UD_KEY_CURRENT_USER),
//       let currentUser = try? JSONDecoder().decode(User.self, from: udCurrentUserData) {
//        return currentUser
//    }
//    return nil
//}
//
//func saveCurrentUserInUD(user: User) {
//    if let udCurrentUserData = try? JSONEncoder().encode(user) {
//        UD.set(udCurrentUserData, forKey: UD_KEY_CURRENT_USER)
//    } else {
//        print("Coudn't save data to user defaults!")
//    }
//}

var currentUserEmail: String {
    get {
        UD.value(forKey: UD_CURRENT_USER_EMAIL) as? String ?? ""
    }
    
    set {
        UD.setValue(newValue, forKey: UD_CURRENT_USER_EMAIL)
    }
}

var currentUserPassword: String {
    get {
        UD.value(forKey: UD_CURRENT_USER_PASSWORD) as? String ?? ""
    }
    
    set {
        UD.setValue(newValue, forKey: UD_CURRENT_USER_PASSWORD)
    }
}

var currentUserRememberME : Bool {
    get {
        UD.value(forKey: UD_KEY_REMEMBER_ME) as? Bool ?? false
    }
    
    set {
        UD.setValue(newValue, forKey: UD_KEY_REMEMBER_ME)
    }
}
