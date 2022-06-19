//
//  DatabaseManager.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 28/08/2021.
//

import FirebaseDatabase
import UIKit

class DatabaseManager {
    static let shared = DatabaseManager()
    let database = Database.database().reference()
    public static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        formatter.locale = .current
        return formatter
    }()
}
