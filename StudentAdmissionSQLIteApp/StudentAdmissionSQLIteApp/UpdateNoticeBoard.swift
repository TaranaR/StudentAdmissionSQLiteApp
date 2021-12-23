//
//  UpdateNoticeBoard.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 18/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class UpdateNoticeBoard: UIViewController {

    private let myTableView=UITableView()
    
    private var noticeArray=[Notice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        view.addSubview(myTableView)
        title = "Notice Board"
        setupTableView()
        myTableView.backgroundColor = UIColor.clear
        let item=UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleadd))
        navigationItem.setRightBarButton(item, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noticeArray = SQLiteHandler.shared.fetchNotice()
        myTableView.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assignbackground()
        setupTableView()
        //toolBar.frame=CGRect(x: 0, y: 65, width: view.frame.size.width, height: 30)
        myTableView.frame=CGRect(x: 0,
                                 y: view.safeAreaInsets.top+70,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    @objc private func handleadd(){
        //print("compose called")
        let vc = AddNotice()
        navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
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
extension UpdateNoticeBoard: UITableViewDataSource,UITableViewDelegate{
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
        cell.textLabel?.text = "\(note.title)"
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
        let vc = AddNotice()
        vc.notice = noticeArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let id = noticeArray[indexPath.row].id
        SQLiteHandler.shared.deleteNotice(for: id){ success in
            if success {
                self.noticeArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }else{
                print("unable to delete from VC")
            }
            
        }
    }
    
}
