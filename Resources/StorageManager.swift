//
//  StorageManager.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 30/08/2021.
//

import Foundation
import FirebaseStorage
class StorageManager {
    static let shared = StorageManager()
    let storage = Storage.storage().reference()
    public typealias UploadImageCompletion = (Result<String, Error>) -> (Void)
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let reference = storage.child(path)
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDownloadURL))
                return }
            completion(.success(url))
        })
    }
   
    ///Uploads picture to Firebase Storage and returns completion with URL string to download
    public func uploadImage(with data: Data, path: String, completion: @escaping  UploadImageCompletion) {
        storage.child(path).putData(data, metadata: nil, completion: { [weak self] metadata, error in
            guard error == nil else {
                print("Failed to upload data to firebase for picture in storage manager file")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self?.storage.child(path).downloadURL(completion: { url, error in
                guard let url = url else {
                    print("Failed to get download url in storage manager")
                    completion(.failure(StorageErrors.failedToGetDownloadURL))
                    return }
                let urlString = url.absoluteString
                print("download url returned: \(urlString)")
                completion(.success(urlString))
            })
            
        })
    }
}
