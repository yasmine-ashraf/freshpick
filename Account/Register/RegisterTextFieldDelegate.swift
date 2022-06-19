//
//  TextFieldDelegate.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 29/08/2021.
//

import Foundation

import UIKit

extension RegisterViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == displayNameField{
            emailField.becomeFirstResponder()
        }
        else if textField == emailField{
            passwordField.becomeFirstResponder()
        }
        return true
    }
}
