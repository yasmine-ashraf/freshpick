//
//  AccountManagement.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import Foundation
extension DatabaseManager {
    ///Gets user's display name
    func getDisplayName(path: String, completion: @escaping (Result<Any, Error>) -> Void) {
        self.database.child("\(path)").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value else {
                completion(.failure(DatabaseError.failedToFetch))
                return }
            completion(.success(value))
        })
    }
    ///Returns true if user exists in database
    public func userExists (with email: String, completion: @escaping ((Bool) -> Void)){
        let safeEmail = email.safeEmail()
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard let savedEmail =  snapshot.value as? [String: Any], !savedEmail.isEmpty  else {
                completion(false)
                return  }
            completion(true)
        })
    }
    ///Inserts a new user to the Database
    public func insertUser(with user: Customer, completion: @escaping (Bool) -> (Void)) {
        database.child(user.safeEmail).setValue(["display_name": user.displayName], withCompletionBlock: { [weak self] error, _ in
            guard error == nil else {
                print("Error inserting user to database")
                completion(false)
                return
            }
            self?.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                if var usersCollection = snapshot.value as? [[String: String]] {
                    let newElement =  ["name": user.displayName,
                                       "email": user.safeEmail
                    ]
                    if !usersCollection.contains(newElement)
                    {
                        usersCollection.append(newElement)
                        self?.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
                            guard error == nil else {
                                completion(false)
                                return }
                            completion(true)
                        }
                        )}
                    else {
                        completion(true)
                    }
                }
                else {
                    let newCollection: [[String:String]] = [
                        ["name": user.displayName,
                         "email": user.safeEmail
                        ]
                    ]
                    self?.database.child("users").setValue(newCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return }
                        completion(true)
                    })
                }
            })
        })
    }
}
