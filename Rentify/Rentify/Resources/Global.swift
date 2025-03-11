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
