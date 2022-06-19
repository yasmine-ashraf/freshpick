//
//  RegisterViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 28/08/2021.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    var isVisible = true
    @IBAction func pwVisibilityButton(_ sender: UIButton) {
        passwordField.isSecureTextEntry = !isVisible
        isVisible = !isVisible
    }
    @IBOutlet weak var displayNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var loginOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginOutlet.layer.borderColor = UIColor.systemGreen.cgColor
        displayNameField.setupField(icon: "person")
        emailField.setupField(icon: "envelope")
        displayNameField.autocapitalizationType = .words
        passwordField.setupField(icon: "lock")
        
    }
}
