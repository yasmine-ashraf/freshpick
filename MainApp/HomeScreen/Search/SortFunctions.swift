//
//  Sorting.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 02/09/2021.
//

import UIKit

extension Array where Element == GroceryItem {
    mutating func sortAlphabetically() {
        sort(by: {( $0.name <  $1.name )
        })
    }
    
    mutating func sortLatestDate() {
        sort(by: {(
            $0.dateAdded > $1.dateAdded)
        })
    }
    
    mutating func sortHighestDiscountRate() {
        sort(by: {(
            $0.discount > $1.discount)
        })
    }
    
    mutating func sortAscendingPrice() {
        sort(by: {(
            Int(Double($0.originalPrice)! * (1-Double($0.discount)!)) < Int(Double($1.originalPrice)! * (1-Double($1.discount)!)))
        })
    }
    
    mutating func sortDescendingPrice() {
        sort(by: {(
            Int(Double($0.originalPrice)! * (1-Double($0.discount)!)) > Int(Double($1.originalPrice)! * (1-Double($1.discount)!)))
        })
    }
}
