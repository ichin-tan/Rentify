//
//  User.swift
//  Rentify
//
//  Created by CP on 11/03/25.
//

import Foundation

class User {
    var id: String
    var email: String
    var role: String

    init(id: String, email: String, role: String) {
        self.id = id
        self.email = email
        self.role = role
    }
}
