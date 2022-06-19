//
//  ValidateAuth.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 29/08/2021.
//

import Foundation
import FirebaseAuth
extension HomeViewController {
    func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil{
            guard let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") else {
                return }
            navigationController?.pushViewController(vc, animated: true)
            self.view.reloadInputViews()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .fullScreen
//            present(nav, animated: false, completion: nil)
        }
        //we need an else in case the app was deleted without logging out
        //Law hasal mashakel remove this:
        else {
            guard let email = FirebaseAuth.Auth.auth().currentUser?.email else
            { return }
            let safeEmail = email.safeEmail()
            UserDefaults.standard.setValue(safeEmail, forKey: "email")
            DatabaseManager.shared.getDisplayName(path: "\(safeEmail)", completion: { [weak self] result in
                switch result{
                case .success(let data):
                    guard let userData = data as? [String:Any],
                          let displayName = userData["display_name"] else {
                        return
                    }
                    UserDefaults.standard.setValue(displayName, forKey: "name")
                    self?.view.reloadInputViews()
                case .failure(let error):
                    print("failed to read data with error: \(error)")
                }
            })
        }
    }
}
