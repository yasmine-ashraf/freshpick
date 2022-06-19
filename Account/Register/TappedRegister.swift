//
//  tappedRegister.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 28/08/2021.
//

import UIKit
import FirebaseAuth

extension RegisterViewController {
    @IBAction func registerButton(_ sender: UIButton) {
        displayNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        guard let displayName = displayNameField.text, let email = emailField.text, let pw = passwordField.text, !displayName.isEmpty, !email.isEmpty, !pw.isEmpty else {
            alertRegisterIncorrect(message: "Please enter all information to sign up")
            return }
        guard pw.count >= 6 else {
            alertRegisterIncorrect(message: "Please enter a valid password. Passwords are atleast 6 characters long")
            return
        }
        guard email.isValidEmail() else {
            alertRegisterIncorrect(message: "Please Enter a valid email address")
            return
        }
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return }
            guard !exists else {
                strongSelf.alertRegisterIncorrect(message: "Email already exists. Please enter a new email or log in")
                return }
//            UserDefaults.standard.set(false, forKey: "notFirstTime")
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: pw, completion: { authResult, error in
                
                guard error == nil, authResult != nil else {
                    print("Error creating user")
                    return
                }
                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue(displayName, forKey: "name")
                let customer = Customer(displayName: displayName, safeEmail: email.safeEmail(), cart: nil)
                DatabaseManager.shared.insertUser(with: customer, completion: { success in
                    if !success {
                        print("error inserting user")
                    }
                })
            })
            NotificationCenter.default.post(name: .reloadHomeNotfication, object: nil)
            strongSelf.navigationController?.popViewController(animated: true)
            strongSelf.navigationController?.popViewController(animated: false)
        })
    }
    func alertRegisterIncorrect(message: String) {
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
