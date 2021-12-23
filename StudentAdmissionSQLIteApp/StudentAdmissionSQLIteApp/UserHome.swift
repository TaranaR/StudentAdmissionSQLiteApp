//
//  UserHome.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 22/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class UserHome: UIViewController {

    private var fields = ["View Profile","Change Password","Read Notice"]
    
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
    
    @objc private func logout(){
        UserDefaults.standard.setValue(nil, forKey: "username")
        checkAuth()
    }
    
    private func checkAuth(){
        let vc = Login()
        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Student Home"
        self.navigationItem.setHidesBackButton(true, animated: true)
        assignbackground()
        setupTableView()
        myTableView.backgroundColor = UIColor.clear
        view.addSubview(myTableView)
        view.addSubview(btnlogout)
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnlogout.frame=CGRect(x: 250, y: myTableView.top+80, width: 150, height: 40)
        myTableView.frame=CGRect(x: 0,
                                 y: 150,
                                 width: view.frame.size.width-20,
                                 height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
}
extension UserHome: UITableViewDataSource, UITableViewDelegate{
    
    private func setupTableView(){
        myTableView.dataSource=self
        myTableView.delegate=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "FieldCell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int)->Int{
        return fields.count;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
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
        
        if(fields[indexPath.row] == "View Profile"){
            let vc = ViewProfile()
            navigationController?.pushViewController(vc, animated: true)
            //present(vc,animated: true, completion: nil)
        }else if (fields[indexPath.row] == "Change Password"){
            let vc = ChangePassword()
            navigationController?.pushViewController(vc, animated: true)
        }else if (fields[indexPath.row] == "Read Notice"){
            let vc = ReadNotice()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
