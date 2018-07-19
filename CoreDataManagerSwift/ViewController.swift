//
//  ViewController.swift
//  CoreDataManagerSwift
//
//  Created by Shanth L on 19/07/18.
//  Copyright © 2018 Shanth L. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //  Add data to the table
        DBManager.SaveData("BookLibrary", ["book_id","book_name","book_status"], ["1","Tamil","1"]) { (boolStatus) in
            print(boolStatus ? "sucesss" : "failure")
        }
        DBManager.SaveData("BookLibrary", ["book_id","book_name","book_status"], ["2","English","2"]) { (boolStatus) in
            print(boolStatus ? "sucesss" : "failure")
        }
        DBManager.SaveData("BookLibrary", ["book_id","book_name","book_status"], ["3","Multimedia","3"]) { (boolStatus) in
            print(boolStatus ? "sucesss" : "failure")
        }
        
        DBManager.SaveData("BookLibrary", ["book_id","book_name","book_status"], ["5","Computer NewWork","4"]) { (boolStatus) in
            print(boolStatus ? "sucesss" : "failure")
        }
        
        //  Fetch  datas from the table
        DBManager.FetchingData("BookLibrary") { (Status, MSG, aryResult) in
            if Status {
                print("sucess ary_list \(aryResult)")
            }else{
                print("sucess ary_list \(MSG)")
            }
        }
        
        //  UPdate  data to the table
        DBManager.UpdateData("BookLibrary", 0, ["book_id","book_name"], ["1","English"]) { (Status, MSG, AryResult) in
            print(MSG)
        }
        
        //  Delete datas from the table
        DBManager.DeleteData("BookLibrary", 0) { (Status, MSG) in
            print(MSG)
        }
        
        
        
        //  Truncate table means remove all datas from the table
        DBManager.TruncateTable("BookLibrary") { (Status, MSG) in
            print(MSG)
        }
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

