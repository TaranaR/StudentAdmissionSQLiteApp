//
//  AddStudent.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AddStudent: UIViewController {

    var student:Student?
    
    private let txtName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Student Name"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtclass: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Class"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    private let txtphone: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        view.addSubview(txtName)
        view.addSubview(txtPassword)
        view.addSubview(txtclass)
        view.addSubview(txtphone)
        view.addSubview(saveButton)
        title = "Add Student"
        if let stud = student{
            txtName.text=stud.Name
            txtPassword.text=stud.Password
            txtclass.text=stud.Class
            txtphone.text=stud.Phone
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        txtName.frame = CGRect(x: 40, y: 170, width: view.frame.size.width - 80, height: 40)
        txtPassword.frame = CGRect(x: 40, y: txtName.bottom+30, width: view.frame.size.width - 80, height: 40)
        txtclass.frame = CGRect(x: 40, y: txtPassword.bottom+30, width: view.frame.size.width - 80, height: 40)
        txtphone.frame = CGRect(x: 40, y: txtclass.bottom+30, width: view.frame.size.width - 80, height: 40)
        saveButton.frame = CGRect(x: 40, y: txtphone.bottom+30, width: view.frame.size.width - 80, height: 40)
    }
   
    @objc private func saveNote(){
        let name = txtName.text!
        let password = txtPassword.text!
        let Class = txtclass.text!
        let phone = txtphone.text!
        
        if let stud = student{
            let updateStud = Student(Spid: stud.Spid, Name: name, Password: password, Class: Class, Phone: phone)
            update(stud: updateStud)
        }else{
            let stud = Student(Spid: 0, Name: name, Password: password, Class: Class, Phone:    phone)
            insert(stud: stud)
        }
    }
    private func insert(stud: Student){
        SQLiteHandler.shared.insert(stud: stud){ success in
            if success{
                print("Insert Successfull, received message at VC")
                self.resetFields()
            }else{
                print("Insert Failed, received message at VC")
            }
        }
    }
    
    private func update(stud: Student){
        SQLiteHandler.shared.update(stud: stud){ success in
            if success{
                print("Update Successfull, received message at VC")
                self.resetFields()
            }else{
                print("Update Failed, received message at VC")
            }
        }
    }
    
    private func resetFields(){
        student = nil
        txtName.text=""
        txtPassword.text=""
        txtclass.text=""
        txtphone.text=""
    }
    
}
