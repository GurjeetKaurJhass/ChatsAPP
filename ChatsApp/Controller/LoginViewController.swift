//
//  LoginViewController.swift
//  ChatsApp
//  Created by Gurjeet kaur on 2020-03-27.
//  Copyright © 2020 The Lambton. All rights reserved.


import UIKit
import Firebase
class LoginViewController: UIViewController {

    let inputsContainerView :UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton:UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleLoginRegister()
    {
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0
               {
                   handleLogin()
               }else{
                   handleRegister()
               }
    }
    func handleLogin()
    {
       guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else
               {
                  print ("form is not valid")
                  return
              }
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if err != nil{
                print(err)
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
    }

    
    let nameTextField:UITextField =
    {
        let tf=UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let nameSeperatorView:UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(r:61, g:220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let emailTextField:UITextField =
    {
        let tf=UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let emailSeperatorView:UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(r:61, g:220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField:UITextField =
    {
        let tf=UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    let passwordSeperatorView:UIView =
    {
        let view = UIView()
        view.backgroundColor = UIColor(r:61, g:220, b:220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
  lazy var profileImageView:UIImageView =
    {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named:"dribbble")
        ImageView.translatesAutoresizingMaskIntoConstraints = false
        ImageView.contentMode = .scaleAspectFill
        ImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfilImageView)))
        ImageView.isUserInteractionEnabled = true
        
        return ImageView
    }()
    
    
    
    let loginRegisterSegmentedControl: UISegmentedControl =
    {
        let sc = UISegmentedControl(items: ["Login","Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self , action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return sc
    }()
    
    @objc func  handleLoginRegisterChange()
   {
    
    let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegisterButton.setTitle(title, for: .normal)
    
    //change height of inputContainerView
    inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
    
    //change height of nameTextFeild
      nameTextFieldHeightAnchor?.isActive = false
       nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo:
        inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0: 1/3)
       nameTextFieldHeightAnchor?.isActive = true
    
   //email text field after handling toogle
    emailTextFieldHeightAnchor?.isActive = false
    emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
    emailTextFieldHeightAnchor?.isActive = true
    
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3 )
           emailTextFieldHeightAnchor?.isActive = true
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        
        
        setupInputContainerView()
        setUploginRegisterButton()
        setUpProfileImage()
        setUpLoginRegiterSegmentedControl()
        
    }
    
    func setUpLoginRegiterSegmentedControl()
    {
    loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
    loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo:inputsContainerView.topAnchor, constant: -12).isActive = true

  loginRegisterSegmentedControl.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        
      loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant:50).isActive = true
    }
    
    func setUpProfileImage()
    {
      profileImageView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
     profileImageView.bottomAnchor.constraint(equalTo:loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setupInputContainerView()
    {
        //x,y,width,height
        inputsContainerView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo:view.widthAnchor,constant: -25).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
       inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(nameSeperatorView)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeperatorView)
        inputsContainerView.addSubview(passwordTextField)
        inputsContainerView.addSubview(passwordSeperatorView)
       
        //need x,y ,width,height constraints
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor,multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //need x,y ,width,height constraints
        nameSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        
        nameSeperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        nameSeperatorView.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        //for setting email constraints
        
        //need x,y ,width,height constraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor=emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor,multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //need x,y ,width,height constraints
        emailSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        
        emailSeperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        
        emailSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        //for setting password constraints
        
        //need x,y ,width,height constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        passwordTextFieldHeightAnchor =  passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor,multiplier: 1/3)
       passwordTextFieldHeightAnchor?.isActive = true
        
        //need x,y ,width,height constraints
        passwordSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        
        passwordSeperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        
        passwordSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        passwordSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        }
    
    
    
    func setUploginRegisterButton()
    {
        loginRegisterButton.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo:inputsContainerView.bottomAnchor,constant: 12).isActive = true
        
        loginRegisterButton.widthAnchor.constraint(equalTo:inputsContainerView.widthAnchor).isActive = true
        
            loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    
}

extension UIColor
{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat)
    {
        
    self.init(red:r/255,green:g/255,blue:b/255,alpha:1)
    
    }


}
