//
//  NewMessageController.swift
//  ChatsApp
//
//  Created by Gurjeet kaur on 2020-04-04.
//  Copyright © 2020 The Lambton. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

   let cellId = "cellId"
   var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
     fetchUser()
    
    }
    
    func fetchUser()
    {
        Database.database().reference().child("user").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]
            {
                let user = User(dictionary: dictionary)
                //user.setValuesForKeys(dictionary)
                self.users.append(user)
         
                DispatchQueue.main.async(execute: {
                                   self.tableView.reloadData()
                               })

            }
         
        }, withCancel: nil)

    }
    @objc func handleCancel()
    {
        dismiss(animated: true, completion: nil)
    }
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        cell.imageView?.image = UIImage(named: "dribbble")
        return cell
    }
}

class UserCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

