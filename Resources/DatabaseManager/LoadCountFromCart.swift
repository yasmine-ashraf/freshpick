//
//  LoadCountFromCart.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 02/09/2021.
//

import UIKit
extension DatabaseManager {
    func loadCountFromCart(array: [GroceryItem], completion: @escaping (Result<[GroceryItem],Error>) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            return
        }
        let safeEmail = email.safeEmail()
        
        database.child("\(safeEmail)/cart").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [[String:Any]] else {
                //Cart empty
                completion(.success(array))
                return
            }
            let newArray: [GroceryItem] = value.compactMap({ dictionary in
                guard let count = dictionary["count"] as? String,
                      let id = dictionary["id"] as? String else {
                    return nil
                }
                let updatedItem = GroceryItem(name: "", category: "", description: "", id: id, originalPrice: "", discount: "", dateAdded: "", image: UIImageView(), count: Int(count)!, availableAmount: 0)
                return updatedItem
            })
            completion(.success(newArray))
        }
        )}
}
