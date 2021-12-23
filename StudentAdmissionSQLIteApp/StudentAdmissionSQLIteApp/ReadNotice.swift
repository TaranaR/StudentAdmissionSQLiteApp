//
//  ReadNotice.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 23/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ReadNotice: UIViewController {

    private let myTableView=UITableView()
    
    private var noticeArray=[Notice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myTableView)
        myTableView.backgroundColor = UIColor.clear
        assignbackground()
        setupTableView()
        title = "Notice Details"
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
        
        noticeArray = SQLiteHandler.shared.fetchNotice()
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
extension ReadNotice: UITableViewDataSource,UITableViewDelegate{
    private func setupTableView(){
        myTableView.dataSource=self
        myTableView.delegate=self
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int)->Int{
        return noticeArray.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = noticeArray[indexPath.row]
        cell.textLabel?.text = "Date : \(note.date) \nTitle : \(note.title) \nDiscription : \(note.discription)"
        cell.textLabel?.numberOfLines=10
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = .clear
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
