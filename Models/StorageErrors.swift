//
//  StorageErrors.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import Foundation
extension StorageManager {
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadURL
    }
}
