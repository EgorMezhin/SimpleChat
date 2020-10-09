//
//  WelcomeViewController.swift
//  SimpleChat
//
//  Created by Egor Lass on 08.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = Constants.appTitle
    }
}
