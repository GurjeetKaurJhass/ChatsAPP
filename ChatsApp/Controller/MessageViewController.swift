//
//  ViewController.swift
//  ChatsApp
//
//  Created by Gurjeet kaur on 2020-03-27.
//  Copyright © 2020 The Lambton. All rights reserved.


import UIKit
import Firebase

class MessageViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
        
        let image = UIImage(named: "icons8-add-to-chat-100")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
           checkIfUserLoggedIn()
        }
        
    @objc func handleNewMessage()
    {
       let newMessageController  = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }
    

    func checkIfUserLoggedIn()
    {
        if Auth.auth().currentUser?.uid == nil{
        perform(#selector(handleLogout), with: nil, afterDelay: 0)
    }
        else
        {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("user").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
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



