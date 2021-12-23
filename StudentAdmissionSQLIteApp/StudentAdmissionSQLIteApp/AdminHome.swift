//
//  AdminHome.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AdminHome: UIViewController {

    private var fields = ["Add New Student","Display Student","Class Wise Student","Update Student","Remove Student","Update NoticeBoard"]
    
    private let myTableView=UITableView()
    
    private let btnlogout: UIButton = {
        let button = UIButton()
        button.setTitle("LOGOUT", for: .normal)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Admin Home"
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.addSubview(myTableView)
        view.addSubview(btnlogout)
        myTableView.backgroundColor = UIColor.clear
        assignbackground()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnlogout.frame=CGRect(x: 250, y: myTableView.top+80, width: 150, height: 40)
        myTableView.frame=CGRect(x: 0,
                                 y: 150,
                                 width: view.frame.size.width-20,
                                 height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    @objc private func logout(){
        UserDefaults.standard.setValue(nil, forKey: "username")
        checkAuth()
    }
    
    private func checkAuth(){
        let vc = Login()
        navigationController?.pushViewController(vc, animated: true)
        //self.present(vc,animated: true, completion: nil)
        
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
extension AdminHome: UITableViewDataSource, UITableViewDelegate{
    
    private func setupTableView(){
        myTableView.dataSource=self
        myTableView.delegate=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FieldCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int)->Int{
        return fields.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell=tableView.dequeueReusableCell(withIdentifier: "FieldCell", for: indexPath)
        cell.textLabel?.text = fields[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.layer.backgroundColor = UIColor.clear.cgColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(fields[indexPath.row] == "Add New Student"){
            let vc = AddStudent()
            navigationController?.pushViewController(vc, animated: true)
            //present(vc,animated: true, completion: nil)
        }else if (fields[indexPath.row] == "Display Student"){
            let vc = DisplayStudent()
            navigationController?.pushViewController(vc, animated: true)
        }else if (fields[indexPath.row] == "Class Wise Student"){
            let vc = ClassWiseStudent()
            navigationController?.pushViewController(vc, animated: true)
        }else if (fields[indexPath.row] == "Update Student"){
            let vc = DisplayStudent()
            navigationController?.pushViewController(vc, animated: true)
        }else if (fields[indexPath.row] == "Remove Student"){
            let vc = DisplayStudent()
            navigationController?.pushViewController(vc, animated: true)
        }else if(fields[indexPath.row] == "Update NoticeBoard"){
            let vc = UpdateNoticeBoard()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
