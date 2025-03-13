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
    
    func getTenantsWhoRequestedForCurrentProperty(completion: (([User]) -> ())?) {
        
        var arrToReturn: [User] = []
        
        if let property = self.properties.first(where: { $0.id == selectedProperty?.id ?? "" }) {
            for (index, requestedTenantId) in property.requestedTenantIds.enumerated() {
                FirebaseManager.shared.fetchUser(for: requestedTenantId) { user in
                    if let user = user {
                        arrToReturn.append(user)
                        if(index == property.requestedTenantIds.count - 1) {
                            completion?(arrToReturn)
                        }
                    } else {
                        print("Coudnt find user data for \(requestedTenantId)!")
                    }
                }
            }
        } else {
            completion?(arrToReturn)
        }
    }
    
    func fetchLandLord(userID: String) {
        FirebaseManager.shared.fetchUser(for: userID) { landlord in
            self.landlord = landlord
        }
    }
    
    func checkIfTenantHasShortlistedProperty(id: String) -> Bool {
        
        if let property = self.properties.first(where: { $0.id == id }) {
            if let currentUserId = FirebaseManager.shared.getCurrentUserUIdFromFirebase() {
                return property.shortListedTenantIds.contains(currentUserId)
            }
        }
        return false
    }
    
    func checkIfTenantHasRequestdForProperty(id: String) -> Bool {
        
        if let property = self.properties.first(where: { $0.id == id }) {
            if let currentUserId = FirebaseManager.shared.getCurrentUserUIdFromFirebase() {
                return property.requestedTenantIds.contains(currentUserId)
            }
        }
        return false
    }
    
    func getShortlistedPropertiesForCurrentUserTenant() -> [Property] {
        var arrToReturn: [Property] = []
        if let currentUserID = FirebaseManager.shared.getCurrentUserUIdFromFirebase() {
            for property in properties {
                if(property.shortListedTenantIds.contains(currentUserID)) {
                    arrToReturn.append(property)
                }
            }
        }
        return arrToReturn
    }
    
    func getRequestedPropertiesForCurrentUserTenant() -> [Property] {
        var arrToReturn: [Property] = []
        if let currentUserID = FirebaseManager.shared.getCurrentUserUIdFromFirebase() {
            for property in properties {
                if(property.requestedTenantIds.contains(currentUserID)) {
                    arrToReturn.append(property)
                }
            }
        }
        return arrToReturn
    }
}
