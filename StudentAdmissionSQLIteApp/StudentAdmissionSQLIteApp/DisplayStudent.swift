//
//  DisplayStudent.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class DisplayStudent: UIViewController {

    private let myTableView=UITableView()
    
    private var studArray=[Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableView)
        myTableView.backgroundColor = UIColor.clear
        assignbackground()
        setupTableView()
        title = "Student Details"
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        studArray = SQLiteHandler.shared.fetch()
        myTableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //toolBar.frame=CGRect(x: 0, y: 65, width: view.frame.size.width, height: 30)
        myTableView.frame=CGRect(x: 0,
                                 y: 150,
                                 width: view.frame.size.width-20,
                                 height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
}
extension DisplayStudent: UITableViewDataSource,UITableViewDelegate{
    private func setupTableView(){
        myTableView.dataSource=self
        myTableView.delegate=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //let temp = SQLiteHandler.shared
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int)->Int{
        return studArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let stud = studArray[indexPath.row]
        cell.textLabel?.text = "\(stud.Name)"
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddStudent()
        vc.student = studArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let spid = studArray[indexPath.row].Spid
        SQLiteHandler.shared.delete(for: spid){ success in
            if success {
                self.studArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }else{
                print("unable to delete from VC")
            }
            
        }
    }
    
}
