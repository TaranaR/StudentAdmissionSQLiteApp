//
//  ChangePassword.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 23/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ChangePassword: UIViewController {

    var student:Student?
    
    private let myPassword:UITextField={
        let textField=UITextField()
        textField.placeholder = "Enter Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 16.0
        textField.backgroundColor = .white
        return textField
    }()
    
    private let myConfirmPasseord:UITextField={
        let textField=UITextField()
        textField.placeholder = "Confirm Password"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 16.0
        textField.backgroundColor = .white
        return textField
    }()
    
    private let btnSave: UIButton = {
        let button = UIButton()
        button.setTitle("SAVE", for: .normal)
        button.addTarget(self, action: #selector(save), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        return button
    }()
    
    @objc func save(){
        if(myPassword.text == myConfirmPasseord.text){
            print("hello")
            let pass = myPassword.text!
            let spid = UserDefaults.standard.string(forKey: "username")!
            SQLiteHandler.shared.changePassword(spid: Int(spid)!, password: pass){
                success in
                if success{
                    print("Passward changed")
                    let alert = UIAlertController(title: "Successful", message: "Password Changed", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default){
                        (action:UIAlertAction!) in
                        let vc = UserHome()
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    print("Change failed")
                }
            }
            
        }else{
            print("should be same")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        title = "Change Password"
        view.addSubview(myPassword)
        view.addSubview(myConfirmPasseord)
        view.addSubview(btnSave)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myPassword.frame = CGRect(x: 10, y: 280, width: view.frame.size.width-20, height: 40)
        myConfirmPasseord.frame=CGRect(x: 10, y: 340, width: view.frame.size.width-20, height: 40)
        btnSave.frame=CGRect(x: 50, y: 400, width: view.frame.size.width-100, height: 40)
    }
    
    func assignbackground(){
        let background = UIImage(named: "studbg")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}
