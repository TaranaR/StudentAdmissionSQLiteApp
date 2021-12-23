//
//  Students.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
class Student{
    var Spid:Int = 0
    var Name:String = ""
    var Password:String = ""
    var Class:String = ""
    var Phone:String = ""
    
    init(Spid:Int, Name:String, Password:String, Class:String, Phone:String) {
        self.Spid=Spid
        self.Name=Name
        self.Password=Password
        self.Class=Class
        self.Phone=Phone
    }
}
