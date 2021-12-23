//
//  Login.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class Login: UIViewController {
    
    private let LoginHead:UILabel={
        let label=UILabel()
        label.text="LOGIN"
        label.textAlignment = .center
        label.font = UIFont(name:"ArialRoundedMTBold", size: 50)
        label.textColor = .white
        return label
    }()
    private let myUname:UITextField={
        let textField=UITextField()
        textField.placeholder = "User Name"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 16.0
        textField.backgroundColor = .white
        return textField
    }()
    
    private let myPassword:UITextField={
        let textField=UITextField()
        textField.placeholder = "Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 16.0
        textField.backgroundColor = .white
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        return button
    }()
    
    @objc private func login(){
        if(myUname.text=="Admin" && myPassword.text=="Admin"){
            UserDefaults.standard.setValue(myUname.text, forKey: "username")
            let vc = AdminHome()
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let uname = Int(myUname.text!)!
            let password = myPassword.text!
            let check = SQLiteHandler.shared.checkValidUser(id: uname, password: password)

            if check == true{
                UserDefaults.standard.setValue(myUname.text, forKey: "username")
                let vc = UserHome()
                navigationController?.pushViewController(vc, animated: true)
            }else{
                let alert = UIAlertController(title: "Alert", message: "Invalid User", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        view.addSubview(LoginHead)
        view.addSubview(myUname)
        view.addSubview(myPassword)
        view.addSubview(loginButton)
        
         self.navigationItem.setHidesBackButton(true, animated: true)
      
    }
    
    func assignbackground(){
        let background = UIImage(named: "loginbg")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        LoginHead.frame=CGRect(x: 15, y: 150, width: view.frame.size.width-40, height: 60)
        myUname.frame = CGRect(x: 10, y: 280, width: view.frame.size.width-20, height: 40)
        myPassword.frame=CGRect(x: 10, y: 340, width: view.frame.size.width-20, height: 40)
        loginButton.frame=CGRect(x: 50, y: 400, width: view.frame.size.width-100, height: 40)
    }
    
}
