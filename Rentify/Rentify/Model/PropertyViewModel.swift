//
//  PropertyViewModel.swift
//  Rentify
//
//  Created by CP on 12/03/25.
//

import Foundation

class PropertyViewModel: ObservableObject {
    
    @Published var properties: [Property] = []
    @Published var selectedProperty: Property? = nil
    @Published var landlord: User?
    
    func fetchProperties() {
        FirebaseManager.shared.fetchProperties { arrProperties in
            self.properties = arrProperties
        }
    }
    
    func getSingleLandlordProperties() -> [Property] {
        return self.properties.filter({ $0.addedByLandlordId == FirebaseManager.shared.getCurrentUserUIdFromFirebase() })
    }
    
    func fetchLandLord(userID: String) {
        FirebaseManager.shared.fetchUser(for: userID) { landlord in
            self.landlord = landlord
        }
    }
}
