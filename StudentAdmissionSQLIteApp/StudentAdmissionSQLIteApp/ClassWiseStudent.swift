//
//  ClassWiseStudent.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ClassWiseStudent: UIViewController {

    private let myTableView=UITableView()
    
    private var studArray=[Student]()
    
    
    private let txtClass:UITextField={
        let textField=UITextField()
        textField.placeholder = "Enter Class"
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        return textField
    }()
    private let FindButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find", for: .normal)
        button.addTarget(self, action: #selector(SearchStud), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        return button
    }()
    
    @objc private func SearchStud(){
        studArray = SQLiteHandler.shared.fetchClass(Class: txtClass.text!)
        myTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        setupTableView()
        myTableView.backgroundColor = UIColor.clear
        title = "Class Wise Student"
        view.addSubview(txtClass)
        view.addSubview(FindButton)
        view.addSubview(myTableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        txtClass.frame = CGRect(x: 10, y: 150, width: 200, height: 30)
        FindButton.frame = CGRect(x: txtClass.right + 50, y: 150, width: 100, height: 30)
        myTableView.frame = CGRect(x: 0, y: FindButton.bottom+10, width: view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
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
extension ClassWiseStudent: UITableViewDataSource,UITableViewDelegate{
    private func setupTableView(){
        myTableView.dataSource=self
        myTableView.delegate=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int)->Int{
        return studArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.textLabel?.text = "\(stud.Name) \t -> \t \(stud.Class)"
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
