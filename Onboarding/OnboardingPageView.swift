//
//  View.swift
//  FreshPick
//
//  Created by Yasmine Ashraf on 26/08/2021.
//

import UIKit
import NotificationCenter

class OnboardingPageView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBAction func nextButton(_ sender: UIButton) {
        let name: Notification.Name
        if buttonLabel.text == "NEXT" {
            name = .nextNotfication
        }
        else {
            name = .doneNotfication
        }
        NotificationCenter.default.post(name: name, object: nil)
    }
    @IBOutlet weak var buttonLabel: UILabel!

}
