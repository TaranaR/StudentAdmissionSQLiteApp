//
//  Notice.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 20/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation

class Notice{
    var id:Int = 0
    var title: String = ""
    var discription:String = ""
    var date:String = ""
    
    init(id:Int, title: String, discription:String, date:String){
        self.id=id
        self.title=title
        self.discription=discription
        self.date=date
    }
}
