//
//  InsertinDatabase.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import Foundation

extension DatabaseManager {
    ///Given the folder name as a path, inserts the item in database
    public func insertItem(path: String, name: String, description: String, category: String, originalprice: String, dateadded: String, discount: String, availableAmount: Int) {
        let id = generateItemId(name: name, category: category)
        database.child(path).observeSingleEvent(of: .value, with: { snapshot in
            let newElement =  ["name": name,
                               "category": category,
                               "description": description,
                               "id": id,
                               "original_price": originalprice,
                               "discount": discount,
                               "date_added": dateadded,
                               "available_amount": String(availableAmount)]
            if var collection = snapshot.value as? [[String: String]] {
                let filterById = collection.filter({ return $0["id"] == id })
                if filterById.isEmpty
                {
                    collection.append(newElement)
                    self.database.child(path).setValue(collection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            return }
                    }
                    )}
                else {
                    print("Ok already exists. Didnt reinsert")
                }
            }
            else {
                let newCollection: [[String:String]] = [newElement]
                self.database.child(path).setValue(newCollection, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        return }
                })
            }
        })
    }
    func generateItemId(name: String, category: String) -> String {
        guard let first = name.first, let last = name.last, let categoryFirst = category.first else {
            print("failed to generate id")
            return "corruptId"
        }
        return "\(first)\(name.count)\(categoryFirst)\(category.count)\(last)".uppercased()
    }
    
    
    
    func updateDescription(path: String, itemId: String, newDescription: String) {
        database.child(path).observeSingleEvent(of: .value, with: { snapshot in
            if var collection = snapshot.value as? [[String: String]] {
                for index in 0..<collection.count {
                    if collection[index]["id"] == itemId {
//                        collection[index]["description"] = newDescription
                        collection[index]["available_amount"] = "20"
                        self.database.child(path).setValue(collection, withCompletionBlock: { error, _ in
                            guard error == nil else {
                                return }
                            print("Updated \(itemId) description")
                        })
                    }
                }
            }
        })
    }
}
