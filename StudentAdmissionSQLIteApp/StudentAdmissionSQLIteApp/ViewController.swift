//
//  ViewController.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 16/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let myLableHead:UILabel={
        let label=UILabel()
        label.text="Student Management"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont(name:"ArialRoundedMTBold", size: 50)
        label.textColor = .white
        //label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let GetStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("GetStarted", for: .normal)
        button.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 6
        return button
    }()
    
    @objc func getStarted(){
        let vc = Login()
        navigationController?.pushViewController(vc, animated: true)
    }
    func assignbackground(){
        let background = UIImage(named: "getbg")
        
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
        view.addSubview(GetStartedButton)
        view.addSubview(myLableHead)
        assignbackground()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myLableHead.frame=CGRect(x: 10, y: 150, width: view.frame.size.width-40, height: 200)
        GetStartedButton.frame = CGRect(x: 40, y: 400, width: view.frame.size.width - 80, height: 40)
    }
    
}

