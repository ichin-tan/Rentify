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
var UD_KEY_CURRENT_USER = "CURRENT_USER"

func getCurrentUserFromUD() -> User? {
    if let udCurrentUserData = UD.data(forKey: UD_KEY_CURRENT_USER),
       let currentUser = try? JSONDecoder().decode(User.self, from: udCurrentUserData) {
        return currentUser
    }
    return nil
}

func saveCurrentUserInUD(user: User) {
    if let udCurrentUserData = try? JSONEncoder().encode(user) {
        UD.set(udCurrentUserData, forKey: UD_KEY_CURRENT_USER)
    } else {
        print("Coudn't save data to user defaults!")
    }
}
