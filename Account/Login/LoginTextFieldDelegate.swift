//
//  TextFieldDelegate.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 29/08/2021.
//

import Foundation
import Foundation

import UIKit

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            passwordField.resignFirstResponder()
        }
        return true
    }
}
