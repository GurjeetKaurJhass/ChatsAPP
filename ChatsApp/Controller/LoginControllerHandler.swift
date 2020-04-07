//
//  LoginControllerHandler.swift
//  ChatsApp
//
//  Created by Gurjeet kaur on 2020-04-05.
//  Copyright © 2020 The Lambton. All rights reserved.


import Foundation
import UIKit
import Firebase

extension LoginViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    @objc func handleRegister()
        {
            guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else
             {
                print ("form is not valid")
                return
            }
           
            Auth.auth().createUser(withEmail: email, password: password, completion: { (res, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let uid = res?.user.uid else {
                    return
                }
                let imageName = NSUUID().uuidString
                let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
                
               
              if let uploadData = self.profileImageView.image!.pngData() {
                    
                    storageRef.putData(uploadData, metadata: nil, completion: { (_, err) in
                        
                        if let error = error {
                            print(error)
                            return
                        }
                        
                        storageRef.downloadURL(completion: { (url, err) in
                            if let err = err {
                                print(err)
                                return
                            }
                            
                            guard let url = url else { return }
                            let values = ["name": name, "email": email, "profileImageUrl": url.absoluteString]
                            
                            self.registerUserIntoDatabaseWithUID(uid, values: values as [String : AnyObject])
                        })
                        
                    })
                }
                
            })

        }
    
    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        let ref = Database.database().reference()
        let usersReference = ref.child("user").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc func handleProfilImageView()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        var selectedImageFromPicker: UIImage?
        
        
       if let editedImage = info["UIImagePickerControllerEditedImage"]as? UIImage
       {
        selectedImageFromPicker = editedImage
       }
         else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage
        {
           selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker
        {
            profileImageView.image = selectedImage
        }
    
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("cancelled picker")
        dismiss(animated: true, completion: nil)
    }
    
    
}
// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}
