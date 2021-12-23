//
//  ViewProfile.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 23/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewProfile: UIViewController {

    var stud = [Student]()
    
    private let lblname:UILabel={
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize:18)
        return lbl
    }()
    private let lblclass:UILabel={
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize:18)
        return lbl
    }()
    private let lblphone:UILabel={
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize:18)
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        title="Profile"
        view.addSubview(lblname)
        view.addSubview(lblclass)
        view.addSubview(lblphone)
        
        let spid = UserDefaults.standard.string(forKey: "username")
        stud = SQLiteHandler.shared.profileDetails(id: Int(spid!)!)
        lblname.text = "Name : " + stud[0].Name
        lblclass.text = "Class : " + stud[0].Class
        lblphone.text = "Phone : " + stud[0].Phone
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        lblname.frame = CGRect(x: 40, y: 150, width: view.frame.size.width - 80, height: 40)
        lblclass.frame = CGRect(x: 40, y: lblname.bottom+30, width: view.frame.size.width - 80, height: 40)
        lblphone.frame = CGRect(x: 40, y: lblclass.bottom+30, width: view.frame.size.width - 80, height: 40)
        
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
