//
//  ViewController.swift
//  ChatsApp
//
//  Created by Gurjeet kaur on 2020-03-27.
//  Copyright © 2020 The Lambton. All rights reserved.


import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        if Auth.auth().currentUser?.uid == nil{
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            
            handleLogout()
        }
    }

    @objc func handleLogout()
    {
        
        
        do{
            try Auth.auth().signOut()
        }catch let logoutError
        {
            print(logoutError)
            
        }
        let loginController = LoginViewController()
        present(loginController,animated: true, completion: nil)
        
    }
}

