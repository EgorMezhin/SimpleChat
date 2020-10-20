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
    
    var db = Firestore.firestore()
    var message: [Message] = []
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if messageField.text != "" {
            if  let messageBody = messageField.text, let messageSender =
                Auth.auth().currentUser?.email {
                db.collection(Constants.FStore.collectionName).addDocument(data: [
                    Constants.FStore.senderField: messageSender,
                    Constants.FStore.bodyField: messageBody,
                    Constants.FStore.dateField: Date().timeIntervalSince1970
                ]) { (error) in
                    if let error = error {
                        print(error)
                    }
                }
                DispatchQueue.main.async {
                    self.messageField.text = ""
                }
            }
        } else {
            self.messageField.placeholder = "Type something"
        }
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
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil),
                           forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            self.message = []
            if let error = error {
                print(error)
            } else {
                if let snapsshotDocument = querySnapshot?.documents {
                    for document in snapsshotDocument {
                        let data = document.data()
                        if let sender = data[Constants.FStore.senderField] as? String,
                            let messageBody = data[Constants.FStore.bodyField] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.message.append(newMessage)
                            
                            DispatchQueue.main.async {
                                 self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.message.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMessage = message[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier,
                                                 for: indexPath) as! MessageTableViewCell
        cell.label.text = "\(message[indexPath.row].body)"
        if currentMessage.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
        } else {
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        return cell
    }
}


