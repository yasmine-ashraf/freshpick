//
//  tappedLogin.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 28/08/2021.
//

import UIKit
import FirebaseAuth

extension LoginViewController {
    @IBAction func loginButton(_ sender: UIButton) {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let email = emailField.text, let pw = passwordField.text, !email.isEmpty, !pw.isEmpty else {
            alertLoginIncorrect(message: "Please enter all information to log in")
            return }
        guard pw.count >= 6 else {
            alertLoginIncorrect(message: "Please enter a valid password. Passwords are atleast 6 characters long")
            return
        }
        guard email.isValidEmail() else {
            alertLoginIncorrect(message: "Please Enter a valid email address")
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pw, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return }
            guard error == nil, let result = authResult else {
                print("Error retrieving user")
                return
            }
            UserDefaults.standard.setValue(email, forKey: "email")
            let safeEmail = email.safeEmail()
            let user = result.user
            DatabaseManager.shared.getDisplayName(path: safeEmail, completion: { result in
                switch result{
                case .success(let data):
                    guard let userData = data as? [String:Any],
                          let displayName = userData["display_name"] else {
                        return
                    }
                    UserDefaults.standard.setValue(displayName, forKey: "name")
                case .failure(let error):
                    print("failed to read data with error: \(error)")
                }
            })
            print("Found user \(user)")
            NotificationCenter.default.post(name: .reloadHomeNotfication, object: nil)
            strongSelf.navigationController?.popViewController(animated: true)
        })
    }
    func alertLoginIncorrect(message: String) {
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
