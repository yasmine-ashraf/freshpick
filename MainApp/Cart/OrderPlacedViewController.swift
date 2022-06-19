//
//  OrderPlacedViewController.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 31/08/2021.
//

import UIKit

class OrderPlacedViewController: UIViewController {

    @IBAction func backToHomeButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    

}
