//
//  User.swift
//  Rentify
//
//  Created by CP on 11/03/25.
//

import Foundation

class User: Codable {
    var id: String
    var name: String
    var email: String
    var contact: String
    var role: String

    init(id: String, name: String, email: String, contact: String, role: String) {
        self.id = id
        self.name = name
        self.email = email
        self.contact = contact
        self.role = role
    }
}
