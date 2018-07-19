//
//  DBManager.swift
//  CoreDataManagerSwift
//
//  Created by Shanth L on 19/07/18.
//  Copyright © 2018 Shanth L. All rights reserved.
//


import UIKit
import CoreData

class DBManager: NSObject {
    
    
    //    var CompletionHandler = (_, success:Bool) -> Void
    
    class func GetContext() -> NSManagedObjectContext {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.persistentContainer.viewContext
    }
    
    
    class func SaveData(_ Tablename: String , _ ary_keys:NSArray , _ ary_values:NSArray, _ handler: @escaping(_ bool_Status : Bool) -> ()) {
        
        let DBContext = GetContext()
        let Entity = NSEntityDescription.entity(forEntityName: Tablename, in: DBContext)
        if (Entity != nil) {
            let managedObj = NSManagedObject(entity: Entity!, insertInto: DBContext)
            for i in 0..<ary_keys.count  {
                managedObj .setValue( ary_values.object(at: i) as! String, forKey: ary_keys.object(at: i) as! String)
            }
            
            do {
                try DBContext.save()
                print("Save")
                handler(true)
            }catch let error as NSError{
                print("\(error.localizedDescription)")
                handler(false)
            }catch{
                handler(false)
            }
            
        }else{
            print("Entity is not available")
            handler(false)
        }
        
    }
    
    
    class func FetchingData(_ Tablename: String , _ handler: @escaping(_ Status : Bool , _ MSG : String, _ ary_result : NSArray) -> ()) {
        let DBContext = GetContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Tablename)
        do {
            let result = try DBContext.fetch(fetchRequest)
            print("Result \(result)")
            handler(true,"sucess",result as NSArray)
        }catch let error as NSError{
            print("\(error.localizedDescription)")
            handler(false,"Failed - > \(error.localizedDescription)",[])
            //  handler(false)
        }catch{
            handler(false,"Failed to fetch the data",[])
        }
    }
    
    class func UpdateData(_ Tablename: String, _ Position: Int, _ ary_keys:NSArray , _ ary_values:NSArray,  _ handler: @escaping(_ Status : Bool , _ MSG : String, _ ary_result : NSArray) -> ()) {
        
        let DBContext = GetContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Tablename)
        
        do{
            let result = try DBContext.fetch(fetchRequest)
            print("Result \(result)")
            let ary_selectedRow = result[Position] as! NSManagedObject
            
            for i in 0 ..< ary_keys.count{
                ary_selectedRow .setValue(ary_values[i] as! String, forKey: ary_keys[i] as! String)
            }
            do{
                try DBContext.save()
                handler(true,"Sucess fully updated",[])
                
            }catch let error as NSError {
                print("UpdatedFAiled \(error.localizedDescription)")
                handler(false,"Failed - > \(error.localizedDescription)",[])
            }catch{
                handler(false,"UpdatedFAiled",[])
            }
            
        }catch let error as NSError{
            print("\(error.localizedDescription)")
            handler(false,"Failed - > \(error.localizedDescription)",[])
            //  handler(false)
        }catch{
            handler(false,"Failed to fetch the data",[])
        }
    }
    
    class func DeleteData(_ Tablename: String, _ Position: Int,  _ handler: @escaping(_ Status : Bool , _ MSG : String) -> ()) {
        
        let DBContext = GetContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Tablename)
        
        do{
            let result = try DBContext.fetch(fetchRequest)
            let ary_row = result[Position]as! NSManagedObject
            DBContext.delete(ary_row)
            do{
                try DBContext.save()
                handler(true,"Deleted Row SucessFully")
            }catch let error as NSError {
                print("Error in Fetching Row in delete qry -> \(error.localizedDescription)")
                handler(false,"Error in Fetching Row in delete qry - > \(error.localizedDescription)")
            }catch{
                handler(false,"DeleteActionFailed in Fetching Row")
            }
            
            
        }catch let error as NSError {
            print("Error in delete qry -> \(error.localizedDescription)")
            handler(false,"Failed - > \(error.localizedDescription)")
        }catch{
            handler(false,"DeleteActionFailed")
        }
        
    }
    
    
    class func TruncateTable(_ Tablename: String,   _ handler: @escaping(_ Status : Bool , _ MSG : String) -> ()) {
        let DBContext = GetContext()
        let FetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Tablename)
        do{
            let result = try DBContext.fetch(FetchRequest)
            for i in 0..<result.count{
                DBContext.delete(result[i] as! NSManagedObject)
            }
            do{
                try DBContext.save()
                handler(true,"Truncated Sucess Fully")
            }catch let error as NSError {
                print("Error in Truncate Qry -> \(error.localizedDescription)")
                handler(false,"Error in Truncate Qry - > \(error.localizedDescription)")
            }catch{
                handler(false,"TruncateAction QRY Failed")
            }
            
            
        }catch let error as NSError {
            print("Error in Fetching Table in Truncate Qry -> \(error.localizedDescription)")
            handler(false,"Error in Fetching Table in Truncate Qry - > \(error.localizedDescription)")
        }catch{
            handler(false,"TruncateActionFailed in Fetching Table")
        }
        
    }
    
}



