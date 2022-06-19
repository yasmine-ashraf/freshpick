//
//  LoginViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 27/08/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    var isVisible = true
    @IBAction func pwVisiblityButton(_ sender: UIButton) {
            passwordField.isSecureTextEntry = !isVisible
            isVisible = !isVisible
    }
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var registerOutlet: UIButton!
    @IBAction func registerButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "RegisterViewController") else {
            return }
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        registerOutlet.layer.borderColor = UIColor.systemGreen.cgColor
//        registerOutlet.layer.borderColor = CGColor(red: 128, green: 207, blue: 0, alpha: 1)
        emailField.setupField(icon: "person")
        passwordField.setupField(icon: "lock")
    }
}
