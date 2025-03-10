//
//  RentifyApp.swift
//  Rentify
//
//  Created by CP on 08/03/25.
//

import SwiftUI
import Firebase

@main
struct RentifyApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
