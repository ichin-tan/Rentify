//
//  FirebaseManager.swift
//  Rentify
//
//  Created by CP on 09/03/25.
//

import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    
    static let shared = FirebaseManager()
    private let db = Firestore.firestore()

    private init() {
        // Just to prevent that outside of this class, no one can make object of this class
    }
    
    //MARK: - GENERAL METHODS
    
    func signupWith(email: String, password: String, completion: ((Bool) -> ())?) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
                completion?(false)
                return
            }
            completion?(true)
        }
    }
    
    func loginWith(email: String, password: String, completion: ((Bool) -> ())?) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
                completion?(false)
                return
            }
            completion?(true)
        }
    }
    
    func logout(completion: ((Bool) -> ())?) {
        do {
            try Auth.auth().signOut()
            completion?(true)
        } catch let signOutError as NSError {
            print(signOutError.localizedDescription)
            completion?(false)
        }
    }
    
    func getCurrentUserUIdFromFirebase() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func createOrUpdateUser(user: User, completion: ((Bool) -> ())?) {
        db.collection(USER_COLLECTION).document(user.id).setData([
            "id": user.id,
            "name": user.name,
            "email": user.email,
            "contact": user.contact,
            "role": user.role
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
                completion?(false)
            } else {
                completion?(true)
            }
        }
    }
    
    func fetchUser(for userId: String, completion: ((User?) -> ())?) {
                
        db.collection(USER_COLLECTION)
            .document(userId)
            .addSnapshotListener { snapshot, error in
                if let snapshot = snapshot {
                    do {
                        let user = try snapshot.data(as: User.self)
                        completion?(user)
                    } catch let error {
                        print(error.localizedDescription)
                        completion?(nil)
                    }
                }
            }        
    }

    //MARK: - LANDLORD - PROPERTIES METHODS

    func addOrUpdateProperty(property: Property, completion: ((Bool) -> ())?) {
        
        db.collection(PROPERTY_COLLECTION).document(property.id).setData([
            "id": property.id,
            "imgUrl": property.imgUrl,
            "streetAddress": property.streetAddress,
            "city": property.city,
            "country": property.country,
            "rent": property.rent,
            "latitude": property.latitude,
            "longitude": property.longitude,
            "addedByLandlordId": property.addedByLandlordId,
            "address": property.address,
            "isActivated": property.isActivated,
            "shortListedTenantIds": property.shortListedTenantIds,
            "requestedTenantIds": property.requestedTenantIds,
            "rentedUserId": property.rentedUserId
        ]) { error in
            if let error = error {
                print(error.localizedDescription)
                completion?(false)
            } else {
                completion?(true)
            }
        }
    }
    
    func fetchProperties(completion: (([Property]) -> ())?) {
        
        var arrToReturn : [Property] = []
        
        db.collection(PROPERTY_COLLECTION)
            .addSnapshotListener({ snapshot, error  in
                
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        do {
                            let property = try document.data(as: Property.self)
                            arrToReturn.append(property)
                        } catch {
                            print("Error while fetching the properties")
                        }
                    }
                    
                    completion?(arrToReturn)
                }
            }
        )
    }
}
