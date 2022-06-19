//
//  DatabaseError.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 28/08/2021.
//

import Foundation
extension DatabaseManager {
    public enum DatabaseError: Error {
        case failedToFetch
    }
}
