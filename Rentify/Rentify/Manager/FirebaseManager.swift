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
    
    func createUser(user: User, completion: ((Bool) -> ())?) {
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
    
    
//    func fetchPlants(completion: (([Plant]) -> ())?) {
//        
//        var arrToReturn : [Plant] = []
//        
//        db.collection(plantsCollection)
//            .addSnapshotListener({ snapshot, error  in
//                
//                if let snapshot = snapshot {
//                    for document in snapshot.documents {
//                        do {
//                            let plant = try document.data(as: Plant.self)
//                            arrToReturn.append(plant)
//                        } catch {
//                            print("Error while fetching the plant")
//                        }
//                    }
//                    
//                    completion?(arrToReturn)
//                }
//            }
//        )
//    }

}
