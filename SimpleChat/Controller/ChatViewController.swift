//
//  ChatViewController.swift
//  SimpleChat
//
//  Created by Egor Lass on 08.10.2020.
//  Copyright © 2020 Egor Mezhin. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    var message: [Message] = [
        Message(sender: "1@b.com", body: "Hi"),
        Message(sender: "2@g.com", body: "Hello"),
        Message(sender: "1@b.com", body: "How are you?")
    ]
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func LogOutBarButtonPressed(_ sender: UIBarButtonItem) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = Constants.appTitle
        navigationItem.hidesBackButton = true
        tableView.allowsSelection = false
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as! MessageTableViewCell
        cell.label.text = "\(message[indexPath.row].body)"
        return cell
    }
}


