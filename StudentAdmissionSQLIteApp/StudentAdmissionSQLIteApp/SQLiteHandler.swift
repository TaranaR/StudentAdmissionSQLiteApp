//
//  SQLiteHandler.swift
//  StudentAdmissionSQLIteApp
//
//  Created by DCS on 17/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import Foundation
import SQLite3

class SQLiteHandler{
    
    static let shared = SQLiteHandler()
    
    let dbPath = "studdb.sqlite"
    var db:OpaquePointer?
    
    private init(){
        db = openDatabase()
        createTable()
        createTableNotice()
    }
    
    func openDatabase() -> OpaquePointer? {
        let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = docURL.appendingPathComponent(dbPath)
        
        var database:OpaquePointer! = nil
        
        if sqlite3_open(fileURL.path, &database) == SQLITE_OK{
            print("Opened connection to the database successfully at: \(fileURL)")
            return database
        }else{
            print("error connecting to the database")
            return nil
        }
    }
    
    func createTable(){
        //SQL Statement
        let createTableString = """
        CREATE TABLE IF NOT EXISTS stud(
        Spid INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT,
        Password TEXT,
        Class TEXT,
        phone TEXT);
        """
        
        //Statement handle
        var createTableStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            
            // Evalute statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("stud table created")
            }else{
                print("stud table could not be created")
            }
            
        }else{
            print("stud table could not be prepared")
        }
        
        //Delete statement
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(stud:Student, completion: @escaping ((Bool)-> Void)){
        let insertStatementString = "INSERT INTO stud (Name, Password, Class, phone) VALUES (?, ?, ?, ?);"
        
        var insertStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(insertStatement, 1, (stud.Name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (stud.Password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (stud.Class as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (stud.Phone as NSString).utf8String, -1, nil)
            
            // Evalute statement
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("insert row successfully")
                completion(true)
            }else{
                print("could row insert row")
                completion(false)
            }
        }else{
            print("insert statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(insertStatement)
    }
    
    func update(stud:Student, completion: @escaping ((Bool)-> Void)){
        let updateStatementString = "UPDATE stud SET Name = ?, Password = ?, Class = ?, Phone = ? WHERE Spid = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK{
            
            sqlite3_bind_text(updateStatement, 1, (stud.Name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (stud.Password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (stud.Class as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 4, (stud.Phone as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 5, Int32(stud.Spid))
            // Evalute statement
            if sqlite3_step(updateStatement) == SQLITE_DONE{
                print("update row successfully")
                completion(true)
            }else{
                print("could row update row")
                completion(false)
            }
        }else{
            print("update statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(updateStatement)
    }
    
    func fetch() ->[Student] {
        let fetchStatementString = "SELECT * FROM stud;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil) == SQLITE_OK{
            
            // Evalute statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW{
                print("fetched row successfully")
                
                let spid = Int(sqlite3_column_int(fetchStatement, 0))
                let name = String(cString: sqlite3_column_text(fetchStatement, 1))
                let password = String(cString: sqlite3_column_text(fetchStatement, 2))
                let sclass = String(cString: sqlite3_column_text(fetchStatement, 3))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 4))
                
                stud.append(Student(Spid: spid, Name: name, Password: password, Class: sclass, Phone: phone))
            }
        }else{
            print("fetch statement could not be prepared")
        }
        //Delete statement
        sqlite3_finalize(fetchStatement)
        return stud
    }
    
    func delete(for Spid:Int, completion: @escaping ((Bool)-> Void)){
        let deleteStatementString = "DELETE FROM stud WHERE Spid = ?;"
        
        var deleteStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK{
            sqlite3_bind_int(deleteStatement, 1, Int32(Spid))
            
            // Evalute statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("delete row successfully")
                completion(true)
            }else{
                print("could row delete row")
                completion(false)
            }
        }else{
            print("delete statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(deleteStatement)
    }
    
    
    func fetchClass(Class:String) ->[Student] {
        let fetchStatementString = "SELECT * FROM stud WHERE Class = ?;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var stud = [Student]()
        // Prepare Statement
        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(fetchStatement, 1, (Class as NSString).utf8String, -1, nil)
            // Evalute statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW{
                print("fetched row successfully")
                
                let spid = Int(sqlite3_column_int(fetchStatement, 0))
                let name = String(cString: sqlite3_column_text(fetchStatement, 1))
                let password = String(cString: sqlite3_column_text(fetchStatement, 2))
                let sclass = String(cString: sqlite3_column_text(fetchStatement, 3))
                let phone = String(cString: sqlite3_column_text(fetchStatement, 4))
                
                stud.append(Student(Spid: spid, Name: name, Password: password, Class: sclass, Phone: phone))
            }
        }else{
            print("fetch statement could not be prepared")
        }
        //Delete statement
        sqlite3_finalize(fetchStatement)
        return stud
    }
    
    func createTableNotice(){
        //SQL Statement
        let createTableString = """
        CREATE TABLE IF NOT EXISTS notice(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        discription TEXT,
        date TEXT);
        """
        
        //Statement handle
        var createTableStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            
            // Evalute statement
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("notice table created")
            }else{
                print("notice table could not be created")
            }
            
        }else{
            print("notice table could not be prepared")
        }
        
        //Delete statement
        sqlite3_finalize(createTableStatement)
    }
    
    func insertNotice(note:Notice, completion: @escaping ((Bool)-> Void)){
        let insertStatementString = "INSERT INTO notice (title, discription, date) VALUES (?, ?, ?);"
        
        var insertStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(insertStatement, 1, (note.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (note.discription as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (note.date as NSString).utf8String, -1, nil)
            
            // Evalute statement
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("insert row successfully")
                completion(true)
            }else{
                print("could row insert row")
                completion(false)
            }
        }else{
            print("insert statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(insertStatement)
    }
    
    func updateNotice(note:Notice, completion: @escaping ((Bool)-> Void)){
        let updateStatementString = "UPDATE notice SET title = ?, discription = ?, date = ? WHERE id = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK{
            
            sqlite3_bind_text(updateStatement, 1, (note.title as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 2, (note.discription as NSString).utf8String, -1, nil)
            sqlite3_bind_text(updateStatement, 3, (note.date as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 4, Int32(note.id))
            // Evalute statement
            if sqlite3_step(updateStatement) == SQLITE_DONE{
                print("update row successfully")
                completion(true)
                
            }else{
                print("could row update row")
                completion(false)
            }
        }else{
            print("update statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(updateStatement)
    }
    
    func fetchNotice() ->[Notice] {
        let fetchStatementString = "SELECT * FROM notice;"
        
        var fetchStatement:OpaquePointer? = nil
        
        var note = [Notice]()
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, fetchStatementString, -1, &fetchStatement, nil) == SQLITE_OK{
            
            // Evalute statement
            while sqlite3_step(fetchStatement) == SQLITE_ROW{
                print("fetched row successfully")
                
                let id = Int(sqlite3_column_int(fetchStatement, 0))
                let title = String(cString: sqlite3_column_text(fetchStatement, 1))
                let dis = String(cString: sqlite3_column_text(fetchStatement, 2))
                let date = String(cString: sqlite3_column_text(fetchStatement, 3))
                
                note.append(Notice(id: id, title: title, discription: dis, date: date))
            }
        }else{
            print("fetch statement could not be prepared")
        }
        //Delete statement
        sqlite3_finalize(fetchStatement)
        return note
    }
    
    func deleteNotice(for id:Int, completion: @escaping ((Bool)-> Void)){
        let deleteStatementString = "DELETE FROM notice WHERE id = ?;"
        
        var deleteStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK{
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            // Evalute statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("delete row successfully")
                completion(true)
            }else{
                print("could row delete row")
                completion(false)
            }
        }else{
            print("delete statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(deleteStatement)
    }
    
    func checkValidUser(id:Int, password:String)->Bool{
        let StatementString = "SELECT * FROM stud WHERE Spid = ? and Password = ?;"
        var flag = 0;
        var Statement:OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, StatementString, -1, &Statement, nil) == SQLITE_OK{
            sqlite3_bind_int(Statement, 1, Int32(id))
            sqlite3_bind_text(Statement, 2, (password as NSString).utf8String, -1, nil)
            
            while sqlite3_step(Statement) == SQLITE_ROW{
                flag=1
            }
        }else{
            print("Data not found")
        }
        
        sqlite3_finalize(Statement)
        
        if(flag==1){
            return true
        }else{
            return false
        }
    }
    func profileDetails(id:Int)->[Student]{
        let StatementString = "SELECT * FROM stud WHERE Spid = ?;"
        var Statement:OpaquePointer? = nil
        
        var stud = [Student]()
        
        if sqlite3_prepare_v2(db, StatementString, -1, &Statement, nil) == SQLITE_OK{
            sqlite3_bind_int(Statement, 1, Int32(id))
            
            while sqlite3_step(Statement) == SQLITE_ROW{
                let spid = Int(sqlite3_column_int(Statement, 0))
                let name = String(cString: sqlite3_column_text(Statement, 1))
                //let password = String(cString: sqlite3_column_text(Statement, 2))
                let sclass = String(cString: sqlite3_column_text(Statement, 3))
                let phone = String(cString: sqlite3_column_text(Statement, 4))
                
                stud.append(Student(Spid: spid, Name: name, Password: "", Class: sclass, Phone: phone))
            }
        }else{
            print("Data not found")
        }
        sqlite3_finalize(Statement)
        return stud
    }
    
    func changePassword(spid:Int, password:String, completion: @escaping ((Bool)-> Void)){
        let updateStatementString = "UPDATE stud SET Password = ? WHERE Spid = ?;"
        
        var updateStatement:OpaquePointer? = nil
        
        // Prepare Statement
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK{
            
            sqlite3_bind_text(updateStatement, 1, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_int(updateStatement, 2,Int32(spid))
            // Evalute statement
            if sqlite3_step(updateStatement) == SQLITE_DONE{
                print("update row successfully")
                completion(true)
                
            }else{
                print("could row update row")
                completion(false)
            }
        }else{
            print("update statement could not be prepared")
            completion(false)
        }
        //Delete statement
        sqlite3_finalize(updateStatement)
    }
    
}
